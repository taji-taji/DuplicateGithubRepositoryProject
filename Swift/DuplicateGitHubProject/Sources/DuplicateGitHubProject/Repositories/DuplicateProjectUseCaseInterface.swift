//
// Created by 多鹿豊 on 2021/04/18.
//

import Apollo
import Foundation

protocol ProjectRepositroyInterface {
    func fetchProject(owner: String, repo: String, projectNumber: Int) -> Result<Project, Error>
    func cloneProject(sourceProjectId: String, targetOwnerId: String, newProjectName: String) -> Result<Int, Error>
}

final class ProjectGraphQLRepositroy: ProjectRepositroyInterface {
    private let httpClient: HTTPClientInterface

    init(httpClient: HTTPClientInterface) {
        self.httpClient = httpClient
    }

    func fetchProject(owner: String, repo: String, projectNumber: Int) -> Result<Project, Error> {
        var project: Project?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        let query = FetchSourceRepositoryQuery(owner: owner, repo: repo, projectNumber: projectNumber)
        self.httpClient.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                guard let projectResult = graphQLResult.data?.repository?.project else {
                    error = APIError.notFound
                    semaphore.signal()
                    return
                }
                project = projectResult.convertToEntity()
                semaphore.signal()
                
            case .failure(let _error):
                error = _error
                semaphore.signal()
            }
        }

        semaphore.wait()
        
        guard let result = project else { return .failure(error!) }
        return .success(result)
    }
    
    func cloneProject(sourceProjectId: String, targetOwnerId: String, newProjectName: String) -> Result<Int, Error> {
        var projectNumber: Int?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        let mutation = CloneProjectMutation(sourceId: sourceProjectId, targetOwnerId: targetOwnerId, projectName: newProjectName)
        self.httpClient.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                guard let number = graphQLResult.data?.cloneProject?.project?.number else {
                    error = APIError.notFound
                    semaphore.signal()
                    return
                }
                projectNumber = number
                semaphore.signal()
                
            case .failure(let _error):
                error = _error
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        
        guard let result = projectNumber else { return .failure(error!) }
        return .success(result)
    }
}

private extension FetchSourceRepositoryQuery.Data.Repository.Project {
    func convertToEntity() -> Project {
        Project(id: id, name: name, number: number, ownerId: owner.id, columns: columns.convertToEntities())
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
