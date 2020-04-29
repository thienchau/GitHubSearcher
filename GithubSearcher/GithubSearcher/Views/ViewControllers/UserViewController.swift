//
//  UserViewController.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit

enum CellType : Int {
    case InfoType = 0
    case RepoType = 1
}

class UserViewController: UIViewController {

    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var tablview: UITableView!
    
    fileprivate var viewModel : UserDetailViewModel?
    
    func initData(user : User) {
        self.viewModel = UserDetailViewModel(user: user)
        self.viewModel!.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tablview.register(UserDetailCell.nib, forCellReuseIdentifier: UserDetailCell.identifier)
        self.tablview.register(RepoCell.nib, forCellReuseIdentifier: RepoCell.identifier)
        
        self.viewModel?.loadData()
    }
    
}

extension UserViewController : UserDetailViewModelDelegate {
    
    func reloadUI() {
        tablview.reloadData()
    }
    
    func showError(_ content: String) {
        Alert.showError(on: self, content: content)
    }
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}

extension UserViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == CellType.InfoType.rawValue {
            return 0
        }
        return RepoCell.HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == CellType.InfoType.rawValue {
            return 1
        }
        return viewModel?.repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == CellType.RepoType.rawValue {

            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.searchBarStyle = .default
            searchBar.placeholder = "Search for User's Repositories"
            searchBar.sizeToFit()
            
            return searchBar
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == CellType.InfoType.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.identifier, for: indexPath) as! UserDetailCell
            cell.selectionStyle = .none
            cell.loadData(viewModel)
            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
            cell.loadData(repo: viewModel?.repos?[indexPath.row])
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == CellType.RepoType.rawValue {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let url = viewModel?.repos?[indexPath.row].url else { return }
            UIApplication.shared.open(url)
        }
    }
}

extension UserViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let str = searchBar.text {
            viewModel?.filter(key: str)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

