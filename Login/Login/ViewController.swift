//
//  ViewController.swift
//  login
//
//  Created by pravda on 22.07.2023.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var signupLabel: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var passLineView: UIView!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    //MARK: - Properties
    
    private let activeColor = UIColor(named: "shadowColor") ?? UIColor.systemGray4
    private let passTextFieldColor = UIColor(named: "passTextFieldColor")
    private let mockPassword = "123456"
    private let mockEmail = "abc@gmail.com"
    
    private var email: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(email.isEmpty || password.isEmpty) ? .systemMint : .systemGray4
        }
    }
    private var password: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(email.isEmpty || password.isEmpty) ? .systemMint : .systemGray4
        }
    }
    
    //MARK: - Live cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonLogin()
        emailTextField.delegate = self
        passTextField.delegate = self
        emailTextField.becomeFirstResponder()
        configureEmailLineView()
        configurePassLineView()
        configureLogoView()
    }
    
    //MARK: - IBActions
    @IBAction func signupAction(_ sender: Any) {
        print("Signup")
    }
    
    @IBAction private func loginAction(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        
        if email == mockEmail,
           password == mockPassword {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error".localised, message: "Wrong password or e-mail".localised, preferredStyle: .alert)
            let action = UIAlertAction(title: "Again".localised , style: .cancel)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
    
    //MARK: - private Methods
    
    private func configureButtonLogin() {
        // Add shadow
        loginButton.layer.shadowColor = UIColor.systemIndigo.cgColor
        loginButton.layer.shadowOffset = CGSize(width: -0.4, height: 2.5)
        loginButton.layer.shadowOpacity = 0.7
        loginButton.layer.shadowRadius = 6
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = .systemGray4
    }
    
    private func configureEmailLineView() {
        emailLineView.layer.shadowColor = UIColor.systemTeal.cgColor
        emailLineView.layer.shadowOffset = CGSize(width: -0.4, height: 2.5)
        emailLineView.layer.shadowOpacity = 0.4
        emailLineView.layer.shadowRadius = 6
    }
    
    private func configurePassLineView() {
        passLineView.layer.shadowColor = UIColor.systemTeal.cgColor
        passLineView.layer.shadowOffset = CGSize(width: -0.4, height: 2.5)
        passLineView.layer.shadowOpacity = 0.4
        passLineView.layer.shadowRadius = 6
    }
    
    private func configureLogoView() {
        logoView.layer.shadowColor = UIColor.systemIndigo.cgColor
        logoView.layer.shadowOffset = CGSize(width: -0.4, height: 2.5)
        logoView.layer.shadowOpacity = 0.4
        logoView.layer.shadowRadius = 6
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            if textField == emailTextField {
                emailLineView.backgroundColor = UIColor.systemMint
                emailImageView.tintColor = UIColor.systemMint
            } else if textField == passTextField {
                passLineView.backgroundColor = UIColor.systemMint
                lockImageView.tintColor = UIColor.systemMint
            }
            return
        }
        switch textField {
        case emailTextField:
            let isValidEmail =  check(email: text)
            
            if isValidEmail {
                email = text
                emailImageView.tintColor = passTextFieldColor
                emailLineView.backgroundColor = passTextFieldColor
            }
            else {
                email = ""
                makeErrorField(textField: textField)
            }
        case passTextField:
            let isValidPassword = check(password: text)
            
            if isValidPassword {
                password = text
                lockImageView.tintColor = passTextFieldColor
                passLineView.backgroundColor = passTextFieldColor
            } else {
                password = ""
                makeErrorField(textField: textField)
            }
        default:
            print("unknown texField")
        }
    }
    
    private func check(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 4
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case emailTextField:
            emailImageView.tintColor = activeColor
            emailLineView.backgroundColor = activeColor
        case passTextField:
            lockImageView.tintColor = activeColor
            passLineView.backgroundColor = activeColor
        default:
            print("unknown texField")
        }
    }
}

