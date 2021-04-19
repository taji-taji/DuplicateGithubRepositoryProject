//
// Created by 多鹿豊 on 2021/04/18.
//

import Apollo
import Combine
import Foundation

protocol DuplicateProjectInputBoundary {
    func fetchSourceProject(owner: String, repo: String, projectNumber: Int) -> Future<Project, Error>
}

final class DuplicateProjectUseCase: DuplicateProjectInputBoundary {
    private let httpClient: HTTPClientInterface

    init(httpClient: HTTPClientInterface) {
        self.httpClient = httpClient
    }

    func fetchSourceProject(owner: String, repo: String, projectNumber: Int) -> Future<Project, Error> {
        Future<Project, Error> { promise in
            let query = FetchSourceRepositoryQuery(owner: owner, repo: repo, projectNumber: projectNumber)
            self.httpClient.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let projectResult = graphQLResult.data?.repository?.project else {
                        promise(.failure(APIError.notFound))
                        return
                    }
                    let project = projectResult.convertToEntity()
                    promise(.success(project))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project {
    func convertToEntity() -> Project {
        Project(id: id, name: name, number: number, columns: columns.convertToEntities())
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project.Column {
    func convertToEntities() -> [ProjectColumn] {
        nodes?.compactMap({ $0?.convertToEntity() }) ?? []
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project.Column.Node {
    func convertToEntity() -> ProjectColumn {
        ProjectColumn(id: id, name: name, cards: cards.convertToEntities())
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project.Column.Node.Card {
    func convertToEntities() -> [ProjectCard] {
        nodes?.compactMap({ $0?.convertToEntity() }) ?? []
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project.Column.Node.Card.Node {
    func convertToEntity() -> ProjectCard {
        ProjectCard(note: note)
    }
}
