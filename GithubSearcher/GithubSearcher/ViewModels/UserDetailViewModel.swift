//
//  UserDetailViewModel.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

protocol UserDetailViewModelDelegate : AnyObject {
    func reloadUI();
    func showError(_ content: String);
    func startLoading();
    func stopLoading();
}

class UserDetailViewModel : NSObject {
    
    weak var delegate : UserDetailViewModelDelegate?
    
    private var user : User? {
        didSet {
            self.delegate?.reloadUI()
        }
    }
    
    var repos : [RepoListItemViewModel]? {
        didSet {
            self.delegate?.reloadUI()
        }
    }
    
    private var reposFull : [RepoListItemViewModel]?
    
    var avatarUrl : URL? {
        return URL(string: user?.avatar_url ?? "")
    }
    var name : String {
        return user?.login ?? ""
    }
    var email : String {
        return user?.email ?? ""
    }
    var location : String {
        return user?.location ?? ""
    }
    var joinDate : String {
        return user?.created_at ?? ""
    }
    var followers : String {
        if let fo = user?.followers {
            return "\(fo) Followers"
        }
        return ""
    }
    var following : String {
        if let fo = user?.following {
            return "Following \(fo)"
        }
        return ""
    }
    var bio : String {
        return user?.bio ?? ""
    }
    
    init(user: User) {
        self.user = user
        if let repos = user.repos {
            self.reposFull = repos.map(RepoListItemViewModel.init)
            self.repos = reposFull
        }
    }
    
    func loadData() {
        
        delegate?.startLoading()
        let request = GetUserDetailRequest(userName: self.name)
        
        _ = APIService.shared.response(from: request) { [weak self]
            response, error in
            
            guard let self = self else {
                return
            }
            
            self.delegate?.stopLoading()
            
            if (error == nil && response != nil) {
                if let response = response as? User {
                    if let message = response.message {
                        self.delegate?.showError(message)
                    } else {
                        self.user = response
                        if self.repos == nil || self.repos?.count == 0 {
                            self.loadRepos()
                        }
                    }
                }
            }
            
        }
    }
    
    func loadRepos() {
        
        delegate?.startLoading()
        
        let request = GetReposRequest(userName: self.name)
        
        _ = APIService.shared.response(from: request) { [weak self]
            response, error in
            
            guard let self = self else {
                return
            }
            
            if (error == nil && response != nil) {
                if let response = response as? [Repo] {
                    self.reposFull = response.map(RepoListItemViewModel.init)
                    self.repos = self.reposFull
                }
            }
            
            self.delegate?.stopLoading()
        }
    }
    
    func filter(key: String) {
        if key.count == 0 {
            self.repos = self.reposFull
            return
        }
        self.repos = self.reposFull?.filter({ (repo) -> Bool in
            return repo.name.lowercased().contains(key.lowercased())
        })
    }
}
