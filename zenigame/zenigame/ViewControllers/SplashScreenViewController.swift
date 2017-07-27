//
//  SplashScreenViewController.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/10/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit
import PureLayout
import SlideMenuControllerSwift

class SplashScreenViewController: UIViewController {

    let iconImgView = UIImageView()
    var constraintsAdded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        iconImgView.image = UIImage(named: "Group")
        iconImgView.clipsToBounds = true
        iconImgView.contentMode = .scaleAspectFit

        if UserDefaultManager.getInstance().getIsSignIn() {
            navToMainPage()
        } else {
            navToSignInPage()
        }

        view.addSubview(iconImgView)
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            iconImgView.autoAlignAxis(toSuperviewAxis: .horizontal)
            iconImgView.autoAlignAxis(toSuperviewAxis: .vertical)
            iconImgView.autoSetDimensions(to: CGSize(width: 200, height: 60))
        }
    }

    func navToSignInPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
            appDelegate.window?.rootViewController = LoginViewController()
        }
    }

    func navToMainPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
            let slideMenuStoryboard = UIStoryboard(name: "SlideMenu", bundle: nil)
            let mainViewController = HomeViewController.instantiate(storyboard: "Home")
            let navigation = UINavigationController(rootViewController: mainViewController)
            let leftViewController = slideMenuStoryboard.instantiateViewController(withIdentifier: "SlideMenuViewController")
            let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: leftViewController)
            appDelegate.window?.rootViewController = slideMenuController
        }
    }

}
