// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AddProjectCardMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation addProjectCard($note: String!, $projectColumnId: String!) {
      addProjectCard(input: {note: $note, projectColumnId: $projectColumnId}) {
        __typename
        clientMutationId
      }
    }
    """

  public let operationName: String = "addProjectCard"

  public var note: String
  public var projectColumnId: String

  public init(note: String, projectColumnId: String) {
    self.note = note
    self.projectColumnId = projectColumnId
  }

  public var variables: GraphQLMap? {
    return ["note": note, "projectColumnId": projectColumnId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addProjectCard", arguments: ["input": ["note": GraphQLVariable("note"), "projectColumnId": GraphQLVariable("projectColumnId")]], type: .object(AddProjectCard.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addProjectCard: AddProjectCard? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addProjectCard": addProjectCard.flatMap { (value: AddProjectCard) -> ResultMap in value.resultMap }])
    }

    /// Adds a card to a ProjectColumn. Either `contentId` or `note` must be provided but **not** both.
    public var addProjectCard: AddProjectCard? {
      get {
        return (resultMap["addProjectCard"] as? ResultMap).flatMap { AddProjectCard(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addProjectCard")
      }
    }

    public struct AddProjectCard: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AddProjectCardPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("clientMutationId", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(clientMutationId: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AddProjectCardPayload", "clientMutationId": clientMutationId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? {
        get {
          return resultMap["clientMutationId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "clientMutationId")
        }
      }
    }
  }
}

public final class CloneProjectMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation cloneProject($sourceId: String!, $targetOwnerId: String!, $projectName: String!) {
      cloneProject(input: {includeWorkflows: true, sourceId: $sourceId, name: $projectName, targetOwnerId: $targetOwnerId}) {
        __typename
        project {
          __typename
          number
        }
      }
    }
    """

  public let operationName: String = "cloneProject"

  public var sourceId: String
  public var targetOwnerId: String
  public var projectName: String

  public init(sourceId: String, targetOwnerId: String, projectName: String) {
    self.sourceId = sourceId
    self.targetOwnerId = targetOwnerId
    self.projectName = projectName
  }

  public var variables: GraphQLMap? {
    return ["sourceId": sourceId, "targetOwnerId": targetOwnerId, "projectName": projectName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("cloneProject", arguments: ["input": ["includeWorkflows": true, "sourceId": GraphQLVariable("sourceId"), "name": GraphQLVariable("projectName"), "targetOwnerId": GraphQLVariable("targetOwnerId")]], type: .object(CloneProject.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(cloneProject: CloneProject? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "cloneProject": cloneProject.flatMap { (value: CloneProject) -> ResultMap in value.resultMap }])
    }

    /// Creates a new project by cloning configuration from an existing project.
    public var cloneProject: CloneProject? {
      get {
        return (resultMap["cloneProject"] as? ResultMap).flatMap { CloneProject(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "cloneProject")
      }
    }

    public struct CloneProject: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CloneProjectPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("project", type: .object(Project.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(project: Project? = nil) {
        self.init(unsafeResultMap: ["__typename": "CloneProjectPayload", "project": project.flatMap { (value: Project) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The new cloned project.
      public var project: Project? {
        get {
          return (resultMap["project"] as? ResultMap).flatMap { Project(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "project")
        }
      }

      public struct Project: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Project"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(number: Int) {
          self.init(unsafeResultMap: ["__typename": "Project", "number": number])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The project's number.
        public var number: Int {
          get {
            return resultMap["number"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "number")
          }
        }
      }
    }
  }
}

public final class FetchSourceRepositoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query fetchSourceRepository($owner: String!, $repo: String!, $projectNumber: Int!) {
      repository(owner: $owner, name: $repo) {
        __typename
        project(number: $projectNumber) {
          __typename
          id
          number
          name
          url
          owner {
            __typename
            id
          }
          columns(first: 10) {
            __typename
            nodes {
              __typename
              id
              name
              cards(first: 10) {
                __typename
                nodes {
                  __typename
                  note
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "fetchSourceRepository"

  public var owner: String
  public var repo: String
  public var projectNumber: Int

  public init(owner: String, repo: String, projectNumber: Int) {
    self.owner = owner
    self.repo = repo
    self.projectNumber = projectNumber
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "repo": repo, "projectNumber": projectNumber]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("repo")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("project", arguments: ["number": GraphQLVariable("projectNumber")], type: .object(Project.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(project: Project? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "project": project.flatMap { (value: Project) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Find project by number.
      public var project: Project? {
        get {
          return (resultMap["project"] as? ResultMap).flatMap { Project(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "project")
        }
      }

      public struct Project: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Project"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("number", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
            GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
            GraphQLField("columns", arguments: ["first": 10], type: .nonNull(.object(Column.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, number: Int, name: String, url: String, owner: Owner, columns: Column) {
          self.init(unsafeResultMap: ["__typename": "Project", "id": id, "number": number, "name": name, "url": url, "owner": owner.resultMap, "columns": columns.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// The project's number.
        public var number: Int {
          get {
            return resultMap["number"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "number")
          }
        }

        /// The project's name.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// The HTTP URL for this project
        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        /// The project's owner. Currently limited to repositories, organizations, and users.
        public var owner: Owner {
          get {
            return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "owner")
          }
        }

        /// List of columns in the project
        public var columns: Column {
          get {
            return Column(unsafeResultMap: resultMap["columns"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "columns")
          }
        }

        public struct Owner: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Organization", "User", "Repository"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public static func makeOrganization(id: GraphQLID) -> Owner {
            return Owner(unsafeResultMap: ["__typename": "Organization", "id": id])
          }

          public static func makeUser(id: GraphQLID) -> Owner {
            return Owner(unsafeResultMap: ["__typename": "User", "id": id])
          }

          public static func makeRepository(id: GraphQLID) -> Owner {
            return Owner(unsafeResultMap: ["__typename": "Repository", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }

        public struct Column: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ProjectColumnConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "ProjectColumnConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of nodes.
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ProjectColumn"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("cards", arguments: ["first": 10], type: .nonNull(.object(Card.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String, cards: Card) {
              self.init(unsafeResultMap: ["__typename": "ProjectColumn", "id": id, "name": name, "cards": cards.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// The project column's name.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// List of cards in the column
            public var cards: Card {
              get {
                return Card(unsafeResultMap: resultMap["cards"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "cards")
              }
            }

            public struct Card: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["ProjectCardConnection"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("nodes", type: .list(.object(Node.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(nodes: [Node?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "ProjectCardConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                }
                set {
                  resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["ProjectCard"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("note", type: .scalar(String.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(note: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "ProjectCard", "note": note])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The card note
                public var note: String? {
                  get {
                    return resultMap["note"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "note")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
