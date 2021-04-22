import ConsoleKit
import Combine
import Foundation

struct DuplicateGitHubProjectCommand: Command {
    struct Signature: CommandSignature {
        @Option(name: "github_access_token", short: "t", help: "GitHub Access Token")
        var githubAccessToken: String?
        
        @Option(name: "new_project_name", short: "n", help: "Name for duplicated project")
        var newProjectName: String?

        @Option(name: "source_project_number", short: "s", help: "Project number for source project")
        var sourceProjectNumber: Int?

        @Option(name: "owner", short: "o", help: "Owner name for project")
        var owner: String?

        @Option(name: "repository_name", short: "r", help: "Repository name for project")
        var repositoryName: String?
    }

    var help: String {
        "This command duplicates a GitHub repository project, including its cards."
    }

    func run(using context: CommandContext, signature: Signature) throws {
        var input: Input
        do {
            input = try parse(signature: signature)
        } catch let error {
            context.console.error(error.localizedDescription)
            var context = context
            outputHelp(using: &context)
            exit(EXIT_FAILURE)
        }
        let repository = ProjectGraphQLRepositroy(httpClient: HTTPClient(githubToken: input.githubAccessToken))
        
        DispatchQueue.global().async {
            // Fetch source project
            let fetchProjectLoadingBar = context.console.loadingBar(title: "Fetching source project")
            fetchProjectLoadingBar.start()
            
            let fetchProjectResult = repository.fetchProject(owner: input.owner,
                                                             repo: input.repositoryName,
                                                             projectNumber: input.sourceProjectNumber)
            
            guard let sourceProject = try? fetchProjectResult.get() else {
                if case let .failure(error) = fetchProjectResult {
                    context.console.error(error.localizedDescription)
                }
                fetchProjectLoadingBar.fail()
                exit(EXIT_FAILURE)
            }

            fetchProjectLoadingBar.succeed()
            
            // Clone project
            let cloneProjectLoadingBar = context.console.loadingBar(title: "Cloning project")
            cloneProjectLoadingBar.start()
            
            let cloneProjectResult = repository.cloneProject(sourceProjectId: sourceProject.id,
                                                             targetOwnerId: sourceProject.ownerId,
                                                             newProjectName: input.newProjectName)
            
            guard let newProjectNumber = try? cloneProjectResult.get() else {
                if case let .failure(error) = fetchProjectResult {
                    context.console.error(error.localizedDescription)
                }
                fetchProjectLoadingBar.fail()
                exit(EXIT_FAILURE)
            }
            
            cloneProjectLoadingBar.succeed()
            
            // Wait for cloning columns
            
            context.console.info("Start adding cards.")
            
            let clonedProjectResult = fetchCloningProject(console: context.console,
                                                          repository: repository,
                                                          owner: input.owner,
                                                          repo: input.repositoryName,
                                                          projectNumber: newProjectNumber,
                                                          sourceProject: sourceProject)
            
            guard let clonedProject = try? clonedProjectResult.get() else {
                if case let .failure(error) = clonedProjectResult {
                    context.console.error(error.localizedDescription)
                }
                exit(EXIT_FAILURE)
            }
            
            // Add cards to cloned project
            
            for sourceProjectColumn in sourceProject.columns {
                guard let column = clonedProject.columns.first(where: { $0.name == sourceProjectColumn.name }) else { break }
                let addCardLoadingBar = context.console.loadingBar(title: "Add cards to column [\(column.name)]")
                addCardLoadingBar.start()
                for card in sourceProjectColumn.cards.reversed() {
                    let result = repository.addProjectCard(note: card.note ?? "", projectColumnId: column.id)
                    guard let _ = try? result.get() else {
                        if case let .failure(error) = result {
                            context.console.error(error.localizedDescription)
                        }
                        addCardLoadingBar.fail()
                        exit(EXIT_FAILURE)
                    }
                }
                addCardLoadingBar.succeed()
            }
            
            context.console.success("Successfully cloned the project.")
            context.console.info("Cloned project: \(clonedProject.urlString)")
            exit(EXIT_SUCCESS)
        }
        
        dispatchMain()
    }
}

private extension DuplicateGitHubProjectCommand {
    struct Input {
        let githubAccessToken: String
        let owner: String
        let newProjectName: String
        let repositoryName: String
        let sourceProjectNumber: Int
    }
    
    struct ParseError: Error, LocalizedError {
        let optionErrors: [OptionError]
        
        var errorDescription: String? {
            optionErrors.map(\.localizedDescription).joined(separator: "\n")
        }
    }
    
    enum OptionError: Error, LocalizedError {
        case missingOption(name: String)
        
        var errorDescription: String? {
            switch self {
            case .missingOption(let name):
                return "Option \(name) is required."
            }
        }
    }
}

private extension DuplicateGitHubProjectCommand {
    func fetchCloningProject(console: Console, repository: ProjectGraphQLRepositroy, owner: String, repo: String, projectNumber: Int, sourceProject: Project) -> Result<Project, Error> {
        let fetchProjectResult = repository.fetchProject(owner: owner, repo: repo, projectNumber: projectNumber)
        
        do {
            let project = try fetchProjectResult.get()
            if project.columns.count == sourceProject.columns.count {
                return .success(project)
            }
            Thread.sleep(forTimeInterval: 1)
            return fetchCloningProject(console: console, repository: repository, owner: owner, repo: repo, projectNumber: projectNumber, sourceProject: sourceProject)
        } catch let error {
            return .failure(error)
        }
    }
    
    func parse(signature: Signature) throws -> Input {
        var optionErrors: [OptionError] = []
        
        var githubAccessToken: String!
        var owner: String!
        var newProjectName: String!
        var repositoryName: String!
        var sourceProjectNumber: Int!
        
        if let _githubAccessToken = signature.githubAccessToken ?? ProcessInfo.processInfo.environment["GITHUB_TOKEN"] {
            githubAccessToken = _githubAccessToken
        } else {
            optionErrors.append(.missingOption(name: signature.$githubAccessToken.name))
        }
        
        if let _owner = signature.owner {
            owner = _owner
        } else {
            optionErrors.append(.missingOption(name: signature.$owner.name))
        }

        if let _newProjectName = signature.newProjectName {
            newProjectName = _newProjectName
        } else {
            optionErrors.append(.missingOption(name: signature.$newProjectName.name))
        }
        
        if let _repositoryName = signature.repositoryName {
            repositoryName = _repositoryName
        } else {
            optionErrors.append(.missingOption(name: signature.$repositoryName.name))
        }
        
        if let _sourceProjectNumber = signature.sourceProjectNumber {
            sourceProjectNumber = _sourceProjectNumber
        } else {
            optionErrors.append(.missingOption(name: signature.$sourceProjectNumber.name))
        }
        
        guard optionErrors.isEmpty else {
            throw ParseError(optionErrors: optionErrors)
        }
        
        return Input(githubAccessToken: githubAccessToken,
                     owner: owner,
                     newProjectName: newProjectName,
                     repositoryName: repositoryName,
                     sourceProjectNumber: sourceProjectNumber)
    }
}
