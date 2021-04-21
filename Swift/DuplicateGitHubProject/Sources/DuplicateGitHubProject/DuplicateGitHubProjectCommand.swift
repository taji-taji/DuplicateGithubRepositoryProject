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
        // TODO: - duplicate GitHub project
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
        let repositroy = ProjectGraphQLRepositroy(httpClient: HTTPClient(githubToken: githubAccessToken))
        
        DispatchQueue.global().async {
            // Fetch source project
            let fetchProjectLoadingBar = context.console.loadingBar(title: "Fetching source project")
            fetchProjectLoadingBar.start()
            
            let fetchProjectResult = repositroy.fetchProject(owner: owner, repo: repositoryName, projectNumber: sourceProjectNumber)
            
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
            
            let cloneProjectResult = repositroy.cloneProject(sourceProjectId: sourceProject.id, targetOwnerId: sourceProject.ownerId, newProjectName: newProjectName)
            
            guard let newProjectId = try? cloneProjectResult.get() else {
                if case let .failure(error) = fetchProjectResult {
                    context.console.error(error.localizedDescription)
                }
                fetchProjectLoadingBar.fail()
                exit(EXIT_FAILURE)
            }
            
            context.console.success("\(newProjectId)")
            cloneProjectLoadingBar.succeed()
            exit(EXIT_SUCCESS)
        }
        
        dispatchMain()
    }
}

