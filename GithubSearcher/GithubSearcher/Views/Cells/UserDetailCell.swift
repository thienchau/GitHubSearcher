//
//  UserDetailCell.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit

class UserDetailCell: GSTableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJoinDate: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    
    
    func loadData(_ user : UserDetailViewModel?) {
        guard let user = user else {
            return
        }
        imgView.kf.setImage(with: user.avatarUrl)
        lblUserName.text = user.name
        if user.email.count == 0 {
            lblEmail.isHidden = true
        } else {
            lblEmail.isHidden = false
            lblEmail.text = user.email
        }
        if user.location.count == 0 {
            lblLocation.isHidden = true
        } else {
            lblLocation.isHidden = false
            lblLocation.text = user.location
        }
        lblJoinDate.text = user.joinDate
        lblFollowing.text = user.following
        lblFollowers.text = user.followers
        lblBio.text = user.bio
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView?.layer.cornerRadius = 70
        imgView?.clipsToBounds = true
        imgView?.contentMode = .scaleAspectFit
        imgView?.backgroundColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
