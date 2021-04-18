//
// Created by 多鹿豊 on 2021/04/18.
//

import Apollo
import Foundation

protocol HTTPClientInterface {
    func fetch<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?)
}

final class HTTPClient: HTTPClientInterface {
    private let client: ApolloClient
    private let endpoint = "https://api.github.com/graphql"

    init(githubToken: String) {
        let configuration: URLSessionConfiguration = .default
        configuration.httpAdditionalHeaders = [
            "Authorization": "token \(githubToken)"
        ]
        let provider = LegacyInterceptorProvider(store: ApolloStore())
        let url = URL(string: endpoint)!
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url)
        client = ApolloClient(networkTransport: requestChainTransport, store: ApolloStore())
    }

    func fetch<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?) {
        client.fetch(query: query, resultHandler: resultHandler)
    }
}
