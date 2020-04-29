//
//  GetReposRequest.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct GetReposRequest: APIRequestType {
    
    typealias Response = [Repo]
    
    var path: String {
        return "users/" + userName + "/repos"
    }
    
    var queryItems: [URLQueryItem]? {
        return []
    }
    
    var userName : String
    
    init(userName: String) {
        self.userName = userName
    }
}
