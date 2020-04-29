//
//  UserListItemViewModel.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation
import UIKit

enum GetReposState {
    case new, succeed, failed
}

class UserListItemViewModel : NSObject {
    
    private(set) var user : User
    var state = GetReposState.new
    
    var avatarUrl : URL? {
        return URL(string: user.avatar_url ?? "")
    }
    var name : String {
        return user.login
    }
    var repos : String {
        if let repos = user.repos {
            return "Repo: \(repos.count)"
        }
        return ""
    }
    
    init(user : User) {
        self.user = user
    }
    
    func setRepos(repos : [Repo]) {
        user.repos = repos
    }

}
