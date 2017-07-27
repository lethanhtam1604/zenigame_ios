//
//  PushManager.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/06/18.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

final class PushManager {

    static func registerNotificationSetting() {
        guard !isEnabled() else {
            return
        }

        // プッシュ許可アラートは一度しか表示されない
        let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
        UIApplication.shared.registerForRemoteNotifications()
        UIApplication.shared.registerUserNotificationSettings(settings)
    }

    static func scheduleLocalNotification(title: String, body: String, delay: Float = 0.0, params: Dictionary<AnyHashable, Any>? = nil) {
        guard isEnabled() else {
            return
        }

        let notification = UILocalNotification()
        if #available(iOS 8.2, *) {
            notification.alertTitle = title
        }
        notification.alertBody = body
        notification.fireDate = Date(timeIntervalSinceNow: TimeInterval(delay))
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        notification.userInfo = params
        UIApplication.shared.scheduleLocalNotification(notification)
    }

    private static func isEnabled() -> Bool {
        guard let settings = UIApplication.shared.currentUserNotificationSettings else {
            return false
        }
        return settings.types.contains(.alert)
    }

}
