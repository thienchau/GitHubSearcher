//
//  RepoCell.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit

class RepoCell: GSTableViewCell {
    
    static let HEIGHT : CGFloat = 44
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFork: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(repo: RepoListItemViewModel?) {
        
        guard let repo = repo else {
            return
        }
        
        lblName.text = repo.name
        lblFork.text = repo.forks
        lblStar.text = repo.stars
    }
}
