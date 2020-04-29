//
//  User.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct User : Decodable {
    
    var message : String?
    
    var login : String
    var id : Int
    var avatar_url : String?
    var repos_url : String
    
    var email : String?
    var location : String?
    var created_at : String?
    var followers : Int?
    var following : Int?
    var bio : String?
    
    var repos : [Repo]?
}
