//
//  AlertHelper.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, title: String, content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showError(on vc: UIViewController, content: String) {
        showBasicAlert(on: vc, title: "Error", content: content)
    }
    
}
