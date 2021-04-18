import ConsoleKit

struct DuplicateGitHubProjectCommand: Command {
    struct Signature: CommandSignature { }

    var help: String {
        "help comment"
    }

    func run(using context: CommandContext, signature: Signature) throws {
        // TODO: - duplicate GitHub project
        context.console.print("Hello, world!")
    }
}

