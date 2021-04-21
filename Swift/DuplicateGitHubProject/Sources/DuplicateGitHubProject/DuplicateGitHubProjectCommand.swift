import ConsoleKit
import Combine
import Foundation

struct DuplicateGitHubProjectCommand: Command {
    struct Signature: CommandSignature {
        @Option(name: "github_access_token", short: "t", help: "GitHub Access Token")
        var githubAccessToken: String?
        
        @Option(name: "new_project_name", short: "n")
        var newProjectName: String?

        @Option(name: "source_project_number", short: "s")
        var sourceProjectNumber: Int?

        @Option(name: "owner", short: "o")
        var owner: String?

        @Option(name: "repository_name", short: "r")
        var repositoryName: String?
    }

    var help: String {
        "help comment"
    }

    func run(using context: CommandContext, signature: Signature) throws {
        guard let githubAccessToken = signature.githubAccessToken ?? ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
            // TODO: Error Handling
            return
        }
        guard let owner = signature.owner else {
            // TODO: Error Handling
            return
        }
        guard let newProjectName = signature.newProjectName else {
            // TODO: Error Handling
            return
        }
        guard let repositoryName = signature.repositoryName else {
            // TODO: Error Handling
            return
        }
        guard let sourceProjectNumber = signature.sourceProjectNumber else {
            // TODO: Error Handling
            return
        }
        let repository = ProjectGraphQLRepositroy(httpClient: HTTPClient(githubToken: githubAccessToken))
        
        DispatchQueue.global().async {
            // Fetch source project
            let fetchProjectLoadingBar = context.console.loadingBar(title: "Fetching source project")
            fetchProjectLoadingBar.start()
            
            let fetchProjectResult = repository.fetchProject(owner: owner, repo: repositoryName, projectNumber: sourceProjectNumber)
            
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
            
            let cloneProjectResult = repository.cloneProject(sourceProjectId: sourceProject.id, targetOwnerId: sourceProject.ownerId, newProjectName: newProjectName)
            
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
            
            let clonedProjectResult = fetchCloningProject(console: context.console, repository: repository, owner: owner, repo: repositoryName, projectNumber: newProjectNumber, sourceProject: sourceProject)
            
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
}
