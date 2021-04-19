import ConsoleKit
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
        guard let view = context.console as? DuplicateProjectViewInterface else { return }
        let presenter = DuplicateProjectPresenter(view: view, inputBoundary: DuplicateProjectUseCase(httpClient: HTTPClient(githubToken: githubAccessToken)))
        presenter.print(owner: owner)
    }
}

