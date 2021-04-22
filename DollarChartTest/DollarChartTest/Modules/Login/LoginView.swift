//
//  WelcomeView.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class LoginView: UIViewController, LoginViewProtocol {

    // MARK: - Public properties
    var presenter: LoginPresenterProtocol?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configVIPER()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Init components
    func configVIPER(){
        LoginRouter.createModule(loginRef: self)
    }

    func setUpView() {
        emailTextField.useUnderline()
        passwordTextField.useUnderline()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Methods
    func validateTextfield() -> Bool {
        if passwordTextField.text!.isEmpty || emailTextField.text!.isEmpty {
            showAlertMessage(titleStr: "Error", messageStr: "Escribe correo y contraseña para ingresar.")
            return false
        } else {
            if emailTextField.text!.isValidEmail(email: emailTextField.text!) {
                if !validatePassword() {
                    showAlertMessage(titleStr: "Error", messageStr: "La contraseña no puede ser igual al correo.")
                    return false
                }
                return true
            } else {
                showAlertMessage(titleStr: "Error", messageStr: "Escribe un correo válido.")
                return false
            }
        }
    }
    
    func validatePassword() -> Bool {
        if passwordTextField.text!.containsIgnoringCase(find: emailTextField.text!) {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func makeLogin(_ sender: Any) {
        if validateTextfield() {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            presenter?.getDataLogin(email: email, password: password)
        }
    }
    
    func errorLogin(detail: ResponseLogin) {
        showAlertMessage(titleStr: "Error", messageStr: detail.message)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(emailTextField.isFirstResponder){
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        if textField == emailTextField || textField == passwordTextField {
            let maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else {
            return true
        }
    }
}

