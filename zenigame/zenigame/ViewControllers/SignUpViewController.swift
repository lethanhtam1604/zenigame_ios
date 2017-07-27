//
//  SignUpViewController.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/10/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    let signUpView = SignUpView()

    override func loadView() {
        view = signUpView

        signUpView.createAccountButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        signUpView.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)

        view.setNeedsUpdateConstraints()
    }

    func signUp() {
        //        if !checkInput(textField: nameField, value: nameField.text) {
        //            return
        //        }
        //        if !checkInput(textField: mailField, value: mailField.text) {
        //            return
        //        }
        //        if !checkInput(textField: businessNameField, value: businessNameField.text) {
        //            return
        //        }
        //        if !checkInput(textField: phoneField, value: phoneField.text) {
        //            return
        //        }
        //        if !checkInput(textField: passwordField, value: passwordField.text) {
        //            return
        //        }
        //        if !checkInput(textField: locationField, value: locationField.text) {
        //            return
        //        }
        //
        //        view.endEditing(true)
        //
        //        SwiftOverlays.showBlockingWaitOverlay()

        let viewController = HomeViewController.instantiate(storyboard: "Home")
        self.present(viewController, animated: true, completion: nil)
    }

    func signIn() {
        dismiss(animated: true, completion: nil)
    }
}
