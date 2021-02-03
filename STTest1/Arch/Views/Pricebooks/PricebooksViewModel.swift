//
//  PricebooksViewModel.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import RxFlow
import RxOptional
import RxRelay
import RxRestClient
import RxSwift

final class PricebooksViewModel: Stepper {
    let ST_API_KEY: String = "45b2c77d-332c-4aec-8595-a2a47b7e9356"
    let steps = PublishRelay<Step>()

    // MARK: - Inputs

    let refresh = PublishRelay<Void>()
    let loadMore = PublishRelay<Void>()

    // MARK: - Outputs

    let pricebooks = PublishRelay<[PricebookItem]>()
    let baseState = PublishRelay<BaseState>()

    // MARK: - Dependencies

    private let disposeBag = DisposeBag()
    private let service: PricebookServiceProtocol

    // MARK: - init

    init(service: PricebookServiceProtocol) {
        self.service = service

        doBindings()
    }

    private func doBindings() {
        let query = PricebooksQuery(page: 1, pageSize: 20, apiKey: ST_API_KEY)
        let state = refresh.map { query }
            .flatMapLatest { [service, loadMore] query in
                service.list(query: query, loadNextPageTrigger: loadMore.asObservable())
            }
            .share()

        state.map(\.state)
            .filterNil()
            .bind(to: baseState)
            .disposed(by: disposeBag)

        state.map(\.response?.data)
            .filterNil()
            .bind(to: pricebooks)
            .disposed(by: disposeBag)
    }
}
