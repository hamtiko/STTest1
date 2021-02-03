//
//  UIScrollView+Extensions.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import UIKit

extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
