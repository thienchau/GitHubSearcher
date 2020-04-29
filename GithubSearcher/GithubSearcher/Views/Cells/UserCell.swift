//
//  UserCell.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: GSTableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRepo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView?.layer.cornerRadius = 25
        imgView?.clipsToBounds = true
        imgView?.contentMode = .scaleAspectFit
        imgView?.backgroundColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(_ user: UserListItemViewModel?) {
        
        guard let user = user else {
            return
        }
        
        self.lblName.text = user.name
        self.lblRepo.text = user.repos
        self.imgView.kf.setImage(with: user.avatarUrl)
        
    }
    
}
