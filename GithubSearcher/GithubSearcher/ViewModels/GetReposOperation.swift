//
//  GetReposOperation.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation
import UIKit

class GetReposOperation : Operation {
    
    weak var tableView : UITableView?
    var indexPath : IndexPath
    var userName : String
    weak var modelView : UserListItemViewModel?
    var dataTask : URLSessionTask?
    
    init(tableView : UITableView, indexPath: IndexPath, name: String, modelView: UserListItemViewModel) {
        self.tableView = tableView
        self.indexPath = indexPath
        self.userName = name
        self.modelView = modelView
    }
    
    override func main() {
        
        if isCancelled {
          return
        }
        
        let request = GetReposRequest(userName: self.userName)
        
        dataTask = APIService.shared.response(from: request) {
            response, error in
            
            if self.isCancelled {
                return
            }
            
            self.modelView?.state = .failed
            
            if (error == nil && response != nil) {
                if let response = response as? [Repo] {
                    self.modelView?.setRepos(repos: response)
                    
                    let isVisible = self.tableView?.indexPathsForVisibleRows?.contains{$0 == self.indexPath}
                    if let v = isVisible, v == true {
                        self.tableView?.reloadRows(at: [self.indexPath], with: .none)
                    }
                    self.modelView?.state = .succeed
                }
            }
        }
    }
    
    override func cancel() {
        super.cancel()
        dataTask?.cancel()
    }
    
}
