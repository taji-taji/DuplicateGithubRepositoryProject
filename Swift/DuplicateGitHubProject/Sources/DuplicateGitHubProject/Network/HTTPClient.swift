//
// Created by 多鹿豊 on 2021/04/18.
//

import Apollo
import Foundation

protocol HTTPClientInterface {
    func fetch<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?)
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, resultHandler: GraphQLResultHandler<Mutation.Data>?)
}

final class HTTPClient: HTTPClientInterface {
    private let client: ApolloClient
    private let endpoint = "https://api.github.com/graphql"

    init(githubToken: String) {
        let provider = LegacyInterceptorProvider(store: ApolloStore())
        let url = URL(string: endpoint)!
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: [
                                                                    "Authorization": "bearer \(githubToken)"
                                                                 ])
        client = ApolloClient(networkTransport: requestChainTransport, store: ApolloStore())
    }

    func fetch<Query: GraphQLQuery>(query: Query, resultHandler: GraphQLResultHandler<Query.Data>?) {
        client.fetch(query: query, resultHandler: resultHandler)
    }
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, resultHandler: GraphQLResultHandler<Mutation.Data>?) {
        client.perform(mutation: mutation, resultHandler: resultHandler)
    }
}
