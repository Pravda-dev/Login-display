//
//  ViewController.swift
//  login
//
//  Created by pravda on 22.07.2023.
//

import UIKit



class ViewController: UIViewController {
    
    @IBAction func signupAction(_ sender: Any) {
        print("Signup")
    }
    @IBAction func loginAction(_ sender: Any) {
        print("Login")
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    private func configureButtonLogin() {
        // Add shadow
        let button = loginButton
        button?.layer.shadowColor = UIColor.systemMint.cgColor
        button?.layer.shadowOffset = CGSize(width: -0.4, height: 2.5)
        button?.layer.shadowOpacity = 0.7
        button?.layer.shadowRadius = 6
    }
    
    
    //MARK: - Live cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonLogin()
        
    }
}
