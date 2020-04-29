//
//  LoginViewController.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/28/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let email = txtEmail.text!
        let pass = txtPassword.text!
        
        if !email.validateEmail() {
            Alert.showError(on: self, content: "Please input correct email")
            return
        }
        
        if !pass.validatePassword() {
            Alert.showError(on: self, content: "Please input correct password (length > 6)")
            return
        }
        
        txtEmail.text = ""
        txtPassword.text = ""
        
        performSegue(withIdentifier: "login", sender: nil)
    }
    
}
