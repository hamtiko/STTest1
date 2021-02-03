//
//  PricebookResponse.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import Foundation
import RxRestClient

struct PricebookResponse: Decodable, PagingResponseProtocol {
    var page: Int
    var pageSize: Int
    var totalCount: Int
    var hasMore: Bool
    var data: [PricebookItem]

    // MARK: - PagingResponseProtocol

    typealias Item = PricebookItem

    static var decoder: JSONDecoder {
        return .init()
    }

    var canLoadMore: Bool { hasMore }

    var items: [PricebookItem] {
        get {
            return data
        }
        set(newValue) {
            data = newValue
        }
    }
}

struct PricebookItem: Decodable {
    var id: Int
    var name: String?
    var price: Double

    var thumbnailUrlString: String {
        return "https://picsum.photos/id/\(id % 1000)/75/75"
    }
}
