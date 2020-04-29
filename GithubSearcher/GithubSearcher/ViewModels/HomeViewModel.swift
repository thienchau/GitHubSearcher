//
//  HomeViewModel.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate : AnyObject {
    func reloadUI();
    func showError(_ content: String);
}

class HomeViewModel : NSObject {
    
    private var page = 1
    private var total = 0
    private var key = ""
    var isCompleted : Bool {
        return data.count == total
    }
    
    var data = [UserListItemViewModel]() {
        didSet {
            self.delegate?.reloadUI()
        }
        willSet {
            self.cancelOperations()
        }
    }
    weak var delegate : HomeViewModelDelegate?
    private var getReposQueue : OperationQueue {
        let queue = OperationQueue()
        queue.name = "GetRepoQueue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }
    
    override init() {
        super.init()
    }
    
    func loadData(key: String) {
        self.key = key
        self.page = 1
        performLoadData()
    }
    
    func cancelOperations() {
        getReposQueue.cancelAllOperations()
        for operation in getReposQueue.operations {
          operation.cancel()
        }
    }
    
    func performLoadData() {
        let request = SearchUsersRequest(key: key, page: page)
        
        _ = APIService.shared.response(from: request) { [weak self]
            response, error in
            
            guard let self = self else {
                return
            }
            
            if (error == nil && response != nil) {
                if let response = response as? SearchUsersResponse {
                    if let message = response.message {
                        self.delegate?.showError(message)
                    } else {
                        self.total = response.total_count ?? 0
                        let data = response.items?.map(UserListItemViewModel.init) ?? []
                        if self.page == 1 {
                            self.data = data
                        } else {
                            self.data += data
                        }
                    }
                }
            }
        }
    }
    
    func clearData() {
        self.data = []
    }
    
    func loadMore() {
        page += 1;
        performLoadData()
    }
    
    func loadRepos(tableView : UITableView, indexPath: IndexPath, modelView: UserListItemViewModel?) {
        
        guard let modelView = modelView else {
            return
        }
        
        if (modelView.state == .succeed || modelView.state == .failed) {
            return
        }
        
        getReposQueue.addOperation(GetReposOperation(tableView: tableView, indexPath: indexPath, name: modelView.name, modelView: modelView))
    }
    
}
