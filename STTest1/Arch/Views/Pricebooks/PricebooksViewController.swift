//
//  PricebooksViewController.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import UIKit

import Reusable

import RxCocoa
import RxSwift

final class PricebooksViewController: UIViewController, StoryboardBased {
    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!

    // MARK: - Dependencies

    var viewModel: PricebooksViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        doBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refresh.accept(())
    }

    private func doBindings() {
        viewModel.pricebooks
            .bind(to: tableView.rx.items, curriedArgument: Self.configureCell)
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .flatMap { [tableView] _ in
                (tableView?.isNearBottomEdge(edgeOffset: 20.0) ?? false)
                    ? Signal.just(())
                    : Signal.empty()
            }
            .bind(to: viewModel.loadMore)
            .disposed(by: disposeBag)
    }
}

private extension PricebooksViewController {
    static func configureCell(tv: UITableView, row: Int, item: PricebookItem) -> PricebookCell {
        let indexPath = IndexPath(row: row, section: 0)
        let cell: PricebookCell = tv.dequeueReusableCell(for: indexPath)
        cell.configure(with: item)
        return cell
    }
}
