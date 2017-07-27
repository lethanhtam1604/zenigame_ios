//
//  LoginViewController.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/7/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {

    let loginView = LoginView()

    override func loadView() {
        view = loginView

        loginView.mailField.delegate = self
        loginView.passwordField.delegate = self
        loginView.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        loginView.termOfService.addTarget(self, action: #selector(termOfService), for: .touchUpInside)
        loginView.contactUs.addTarget(self, action: #selector(contactUS), for: .touchUpInside)

        view.setNeedsUpdateConstraints()
    }

    func signIn() {
        // 開発都合のため、一旦コメントアウトさせていただきますmm
        //         if !checkInput(textField: loginView.mailField, value: loginView.mailField.text) {
        //             return
        //         }
        //         if !checkInput(textField: loginView.passwordField, value: loginView.passwordField.text) {
        //             return
        //         }
        //
        //         view.endEditing(true)
        //
        UserDefaultManager.getInstance().setIsSignIn(value: true)

        let mainViewController = HomeViewController.instantiate(storyboard: "Home")
        let navigation = UINavigationController(rootViewController: mainViewController)
        let leftViewController = SlideMenuViewController.instantiate(storyboard: "SlideMenu")

        let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: leftViewController)
        self.present(slideMenuController, animated: true, completion: nil)
    }

    func termOfService() {

    }

    func contactUS() {

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string) // swiftlint:disable:this force_unwrapping
        _ = checkInput(textField: textField, value: newString)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginView.mailField:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()
                loginView.passwordField.becomeFirstResponder()
                return true
            }
        default:
            if checkInput(textField: textField, value: textField.text) {
                textField.resignFirstResponder()

                return true
            }
        }
        return false
    }

    func checkInput(textField: UITextField, value: String?) -> Bool {
        switch textField {
        case loginView.mailField:
            if let v = value, v.isValidEmail() {
                loginView.errorLabel.text = nil
                loginView.mailBorder.backgroundColor = Global.colorSeparator
                return true
            }
            loginView.errorLabel.text = "Invalid email"
            loginView.mailBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)

        default:
            if let v = value, v.isValidPassword() {
                loginView.errorLabel.text = nil
                loginView.passwordBorder.backgroundColor = Global.colorSeparator
                return true
            }
            loginView.errorLabel.text = "Invalid password"
            loginView.passwordBorder.backgroundColor = UIColor.red.withAlphaComponent(0.8)

        }
        return false
    }
}
