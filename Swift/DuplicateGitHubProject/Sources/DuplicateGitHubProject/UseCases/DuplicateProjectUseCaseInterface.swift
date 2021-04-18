//
// Created by 多鹿豊 on 2021/04/18.
//

import Foundation
import Apollo

protocol DuplicateProjectUseCaseInterface {
    func fetchSourceProject(owner: String, repo: String, projectNumber: Int)
}

final class DuplicateProjectUseCase: DuplicateProjectUseCaseInterface {
    private let httpClient: HTTPClientInterface

    init(httpClient: HTTPClientInterface) {
        self.httpClient = httpClient
    }

    func fetchSourceProject(owner: String, repo: String, projectNumber: Int) {
        let query = FetchSourceRepositoryQuery(owner: owner, repo: repo, projectNumber: projectNumber)
        httpClient.fetch(query) { result, error in
            
        }
    }
}
