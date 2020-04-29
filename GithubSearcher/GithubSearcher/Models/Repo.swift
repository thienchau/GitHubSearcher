//
//  Repo.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct Repo : Decodable {
    
    var id : Int?
    var name : String?
    var stargazers_count : Int?
    var forks_count : Int?
    var html_url : String?
}
