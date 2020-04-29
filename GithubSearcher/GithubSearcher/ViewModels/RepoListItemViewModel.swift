//
//  RepoListItemViewModel.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

class RepoListItemViewModel: NSObject {
    
    private(set) var repo : Repo
    
    var name : String {
        return repo.name ?? ""
    }
    
    var url : URL? {
        return URL(string: repo.html_url ?? "")
    }
    
    var forks : String {
        if let forks = repo.forks_count {
            return "\(forks) Forks"
        }
        return ""
    }
    
    var stars : String {
        if let stars = repo.stargazers_count {
            return "\(stars) Stars"
        }
        return ""
    }
    
    init(repo : Repo) {
        self.repo = repo
    }
}
