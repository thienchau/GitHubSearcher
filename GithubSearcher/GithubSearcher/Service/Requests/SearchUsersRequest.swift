//
//  SearchUsersRequest.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct SearchUsersRequest: APIRequestType {
    
    typealias Response = SearchUsersResponse
    
    var path: String {
        return "search/users"
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: key),
            .init(name: "page", value: String(page)),
            .init(name: "per_page", value: "20")
        ]
    }
    
    var page : Int
    var key : String
    
    init(key: String, page: Int) {
        self.page = page
        self.key = key
    }
}
