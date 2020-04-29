//
//  SearchUsersResponse.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

struct SearchUsersResponse : Decodable {
    
    var total_count : Int?
    var incomplete_results : Bool?
    var items : [User]?
    var message : String?
    
}
