//
//  PricebooksQuery.swift
//  STTest1
//
//  Created by Tigran Hambardzumyan on 03.02.21.
//

import RxRestClient

struct PricebooksQuery: Encodable, PagingQueryProtocol {
    var page: Int
    let pageSize: Int
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case page = "filter.page"
        case pageSize = "filter.pageSize"
        case apiKey = "serviceTitanApiKey"
    }

    func nextPage() -> PricebooksQuery {
        var new = self
        new.page += 1
        return new
    }
}
