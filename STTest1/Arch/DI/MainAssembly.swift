//
//  MainAssembly.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//
import Foundation

import Swinject
import SwinjectAutoregistration

import RxRestClient

final class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(PricebooksViewModel.self, initializer: PricebooksViewModel.init)
        container.register(PricebooksViewController.self) { r in
            let controller = PricebooksViewController.instantiate()
            controller.viewModel = r ~> PricebooksViewModel.self
            return controller
        }

        container.autoregister(RxRestClient.self, initializer: self.provideRestClient)
        container.autoregister(PricebookServiceProtocol.self, initializer: PricebookService.init)
    }

    private func provideRestClient() -> RxRestClient {
        let options = RxRestClientOptions.default
        return RxRestClient(baseUrl: URL(string: "https://api.servicetitan.com/v1/"), options: options)
    }
}
