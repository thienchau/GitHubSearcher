//
//  ViewController.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var viewModel : HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.identifier)
        self.tableView.register(LoadMoreCell.nib, forCellReuseIdentifier: LoadMoreCell.identifier)
        self.searchBar.becomeFirstResponder()
        
        self.viewModel = HomeViewModel()
        self.viewModel!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false);
    }
}

extension HomeViewController : HomeViewModelDelegate {
    
    func reloadUI() {
        tableView.reloadData()
    }
    
    func showError(_ content: String) {
        Alert.showBasicAlert(on: self, title: "Error", content: content)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewModel = viewModel else {
            return 0
        }
        
        let count = viewModel.data.count
        
        return count == 0 ? count : (count + (viewModel.isCompleted ? 0 : 1))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == viewModel?.data.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreCell.identifier, for: indexPath) as! LoadMoreCell
            cell.indicator.startAnimating()
            cell.selectionStyle = .none
            viewModel?.loadMore()
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        let itemViewModel = viewModel?.data[indexPath.row]
        
        viewModel?.loadRepos(tableView: tableView, indexPath: indexPath, modelView: itemViewModel)
        cell.loadData(viewModel?.data[indexPath.row])
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel?.data.count {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "detail", sender: viewModel?.data[indexPath.row].user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? UserViewController {
            des.initData(user: sender as! User)
        }
    }
}

extension HomeViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let str = searchBar.text {
            if str.count == 0 {
                viewModel?.clearData()
            } else {
                viewModel?.loadData(key: str)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



