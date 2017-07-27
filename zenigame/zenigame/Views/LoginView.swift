//
//  LoginView.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/7/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

class LoginView: UIView {

    let scrollView = UIScrollView()
    let containerView = UIView()

    let iconImgView = UIImageView()
    let errorLabel = UILabel()

    let mailView = UIView()
    let mailField = UITextField()
    let mailAbstract = UIView()
    let mailImgView = UIImageView()
    let mailBorder = UIView()

    let passwordView = UIView()
    let passwordField = UITextField()
    let passwordAbstract = UIView()
    let keyImgView = UIImageView()
    let passwordBorder = UIView()

    let signInButton = UIButton()

    let termOfService = UIButton()
    let contactUs = UIButton()

    var constraintsAdded = false

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = UIColor.white
        tintColor = Global.colorSignin
        addTapToDismiss()

        iconImgView.clipsToBounds = true
        iconImgView.contentMode = .scaleAspectFit
        iconImgView.image = UIImage(named: "Group")

        mailImgView.clipsToBounds = true
        mailImgView.contentMode = .scaleAspectFit
        mailImgView.image = UIImage(named: "Mail")

        keyImgView.clipsToBounds = true
        keyImgView.contentMode = .scaleAspectFit
        keyImgView.image = UIImage(named: "Key")

        errorLabel.font = UIFont(name: "OpenSans", size: 14)
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.red.withAlphaComponent(0.7)
        errorLabel.adjustsFontSizeToFitWidth = true

        mailField.textAlignment = .center
        mailField.placeholder = "Email"
        mailField.textColor = UIColor.black
        mailField.returnKeyType = .next
        mailField.keyboardType = .emailAddress
        mailField.inputAccessoryView = UIView()
        mailField.autocorrectionType = .no
        mailField.autocapitalizationType = .none
        mailField.font = UIFont(name: "OpenSans", size: 17)
        mailBorder.backgroundColor = Global.colorSeparator
        mailAbstract.backgroundColor = UIColor.white
        mailView.bringSubview(toFront: mailAbstract)

        passwordField.textAlignment = .center
        passwordField.placeholder = "Password"
        passwordField.textColor = UIColor.black
        passwordField.returnKeyType = .go
        passwordField.keyboardType = .default
        passwordField.isSecureTextEntry = true
        passwordField.inputAccessoryView = UIView()
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.font = UIFont(name: "OpenSans", size: 17)
        passwordBorder.backgroundColor = Global.colorSeparator
        passwordAbstract.backgroundColor = UIColor.white
        passwordView.bringSubview(toFront: passwordAbstract)

        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.backgroundColor = Global.colorSignin
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.setTitleColor(Global.colorSelected, for: .highlighted)
        signInButton.layer.cornerRadius = 5
        signInButton.titleLabel?.font = UIFont(name: "OpenSans-semibold", size: 15)
        signInButton.clipsToBounds = true

        termOfService.setTitle("ご利用規約", for: .normal)
        termOfService.setTitleColor(Global.colorGray, for: .normal)
        termOfService.setTitleColor(Global.colorSignin, for: .highlighted)
        termOfService.titleLabel?.font = UIFont(name: "OpenSans", size: 17)
        termOfService.sizeToFit()
        termOfService.contentHorizontalAlignment = .center

        contactUs.setTitle("お問い合わせ", for: .normal)
        contactUs.setTitleColor(Global.colorGray, for: .normal)
        contactUs.setTitleColor(Global.colorSignin, for: .highlighted)
        contactUs.titleLabel?.font = UIFont(name: "OpenSans", size: 17)
        contactUs.sizeToFit()
        contactUs.contentHorizontalAlignment = .center

        mailAbstract.addSubview(mailImgView)
        mailView.addSubview(mailField)
        mailView.addSubview(mailBorder)
        mailView.addSubview(mailAbstract)

        passwordAbstract.addSubview(keyImgView)
        passwordView.addSubview(passwordField)
        passwordView.addSubview(passwordBorder)
        passwordView.addSubview(passwordAbstract)

        containerView.addSubview(iconImgView)
        containerView.addSubview(errorLabel)
        containerView.addSubview(mailView)
        containerView.addSubview(passwordView)
        containerView.addSubview(signInButton)
        containerView.addSubview(termOfService)
        containerView.addSubview(contactUs)
        scrollView.addSubview(containerView)

        addSubview(scrollView)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            scrollView.autoPinEdgesToSuperviewEdges()

            containerView.autoPinEdgesToSuperviewEdges()
            containerView.autoMatch(.width, to: .width, of: self)

            let alpha: CGFloat = 40

            iconImgView.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
            iconImgView.autoSetDimensions(to: CGSize(width: 200, height: 45))
            iconImgView.autoAlignAxis(toSuperviewAxis: .vertical)

            //---------------------------------------------------------------------------

            errorLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            errorLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            errorLabel.autoPinEdge(.top, to: .bottom, of: iconImgView, withOffset: 30)
            errorLabel.autoSetDimension(.height, toSize: 20)

            //---------------------------------------------------------------------------

            mailView.autoPinEdge(toSuperviewEdge: .left, withInset: alpha)
            mailView.autoPinEdge(toSuperviewEdge: .right, withInset: alpha)
            mailView.autoPinEdge(.top, to: .bottom, of: errorLabel, withOffset: 20)
            mailView.autoSetDimension(.height, toSize: 40)

            mailField.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            mailField.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            mailField.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            mailField.autoSetDimension(.height, toSize: 40)

            mailAbstract.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            mailAbstract.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            mailAbstract.autoPinEdge(toSuperviewEdge: .bottom, withInset: 1)
            mailAbstract.autoSetDimension(.width, toSize: 25)

            mailImgView.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
            mailImgView.autoPinEdge(toSuperviewEdge: .left, withInset: 1)
            mailImgView.autoSetDimensions(to: CGSize(width: 15, height: 15))

            mailBorder.autoPinEdge(toSuperviewEdge: .left)
            mailBorder.autoPinEdge(toSuperviewEdge: .right)
            mailBorder.autoPinEdge(toSuperviewEdge: .bottom)
            mailBorder.autoSetDimension(.height, toSize: 0.7)

            //---------------------------------------------------------------------------

            passwordView.autoPinEdge(toSuperviewEdge: .left, withInset: alpha)
            passwordView.autoPinEdge(toSuperviewEdge: .right, withInset: alpha)
            passwordView.autoPinEdge(.top, to: .bottom, of: mailView, withOffset: 10)
            passwordView.autoSetDimension(.height, toSize: 40)

            passwordField.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            passwordField.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            passwordField.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            passwordField.autoSetDimension(.height, toSize: 40)

            passwordAbstract.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            passwordAbstract.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            passwordAbstract.autoPinEdge(toSuperviewEdge: .bottom, withInset: 1)
            passwordAbstract.autoSetDimension(.width, toSize: 25)

            keyImgView.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
            keyImgView.autoPinEdge(toSuperviewEdge: .left, withInset: 1)
            keyImgView.autoSetDimensions(to: CGSize(width: 15, height: 15))

            passwordBorder.autoPinEdge(toSuperviewEdge: .left)
            passwordBorder.autoPinEdge(toSuperviewEdge: .right)
            passwordBorder.autoPinEdge(toSuperviewEdge: .bottom)
            passwordBorder.autoSetDimension(.height, toSize: 0.7)

            //---------------------------------------------------------------------------

            signInButton.autoPinEdge(toSuperviewEdge: .left, withInset: alpha - 2)
            signInButton.autoPinEdge(toSuperviewEdge: .right, withInset: alpha - 2)
            signInButton.autoPinEdge(.top, to: .bottom, of: passwordView, withOffset: 30)
            signInButton.autoSetDimension(.height, toSize: 40)

            //---------------------------------------------------------------------------

            termOfService.autoPinEdge(.top, to: .bottom, of: signInButton, withOffset: 150)
            termOfService.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            termOfService.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            termOfService.autoSetDimension(.height, toSize: 30)

            contactUs.autoPinEdge(.top, to: .bottom, of: termOfService, withOffset: 10)
            contactUs.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            contactUs.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            contactUs.autoSetDimension(.height, toSize: 30)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let height: CGFloat = 145 + 50 + 60 + 50 + 70 + 180 + 40 + 10
        containerView.autoSetDimension(.height, toSize: height)
        scrollView.contentSize = CGSize(width: frame.width, height: height)
    }
}
