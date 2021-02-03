//
//  PricebookService.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import RxRestClient
import RxSwift

protocol PricebookServiceProtocol {
    func list(query: PricebooksQuery, loadNextPageTrigger: Observable<Void>) -> Observable<PricebooksState>
}

final class PricebookService: PricebookServiceProtocol {
    private let client: RxRestClient

    init(client: RxRestClient) {
        self.client = client
    }

    func list(query: PricebooksQuery, loadNextPageTrigger: Observable<Void>) -> Observable<PricebooksState> {
        return client.get(Endpoints.list, query: query, loadNextPageTrigger: loadNextPageTrigger)
    }
}
