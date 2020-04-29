//
//  GetUserDetailRequest.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct GetUserDetailRequest: APIRequestType {
    
    typealias Response = User
    
    var path: String {
        return "users/" + userName
    }
    
    var queryItems: [URLQueryItem]? {
        return []
    }
    
    var userName : String
    
    init(userName: String) {
        self.userName = userName
    }
}
