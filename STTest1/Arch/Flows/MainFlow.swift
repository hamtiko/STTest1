//
//  MainFlow.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import UIKit

import Swinject
import SwinjectAutoregistration

import RxFlow

final class MainFlow: Flow {
    var root: Presentable {
        rootViewController
    }

    private let rootViewController = UINavigationController()
    private let assemblies: [Assembly] = [
        MainAssembly()
    ]
    private let assembler: Assembler!

    init() {
        assembler = Assembler(assemblies)
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .main:
            return navigateToMain()
//            We will need this when we have more than one steps
//        default:
//            return .none
        }
    }

    private func navigateToMain() -> FlowContributors {
        let controller = assembler.resolver ~> PricebooksViewController.self

        rootViewController.pushViewController(controller, animated: false)

        return .one(flowContributor: .contribute(withNextPresentable: controller, withNextStepper: controller.viewModel))
    }
}
