//
//  PricebookCell.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import UIKit

import Reusable
import Kingfisher

final class PricebookCell: UITableViewCell, Reusable {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    func configure(with pricebook: PricebookItem) {
        name.text = pricebook.name
        price.text = Self.currencyFormatter.string(from: NSNumber(value: pricebook.price))

        if let url = URL(string: pricebook.thumbnailUrlString) {
            imgView.kf.setImage(with: url)
        }
    }
}
