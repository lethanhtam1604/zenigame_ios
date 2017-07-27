//
//  AppDelegate.swift
//  zenigame
//
//  Created by ykkc on 2017/04/05.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //Set root view controlller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.black
        self.window?.makeKeyAndVisible()

        self.window?.rootViewController = SplashScreenViewController()

        // keyboard
        let keyboardManager = IQKeyboardManager.shared()
        keyboardManager.isEnabled = true
        keyboardManager.previousNextDisplayMode = .alwaysShow
        keyboardManager.shouldShowTextFieldPlaceholder = false

        //change orientation
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        return true
    }

    var isInit = false
    func rotated() {
        if isInit {
            return
        }

        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            Global.SCREEN_WIDTH = UIScreen.main.bounds.size.height
            Global.SCREEN_HEIGHT = UIScreen.main.bounds.size.width
            isInit = true
        }

        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            Global.SCREEN_WIDTH = UIScreen.main.bounds.size.width
            Global.SCREEN_HEIGHT = UIScreen.main.bounds.size.height
            isInit = true
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("ローカルプッシュから起動or復帰 userInfo: \(String(describing: notification.userInfo))")
        if application.applicationIconBadgeNumber != 0 {
            application.applicationIconBadgeNumber = 0
        }
    }

}
