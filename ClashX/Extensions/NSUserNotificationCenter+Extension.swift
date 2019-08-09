//
//  NSUserNotificationCenter+Extension.swift
//  ClashX
//
//  Created by CYC on 2018/8/6.
//  Copyright © 2018年 yichengchen. All rights reserved.
//

import Cocoa

extension NSUserNotificationCenter {
    func post(title:String,info:String,identifier:String? = nil) {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = info
        if identifier != nil {
            notification.userInfo = ["identifier":identifier!]
        }
        self.delegate = UserNotificationCenterDelegate.shared
        self.deliver(notification)
    }
    
    func postGenerateSimpleConfigNotice() {
        self.post(title: NSLocalizedString("Sample Config File Created!", comment: ""),
                  info: NSLocalizedString("We have created or replaced your current config with a simple config with external-controller specified!",comment: ""))
    }
    
    func postConfigFileChangeDetectionNotice() {
        self.post(title: NSLocalizedString("Config file have been changed", comment: ""),
                  info: NSLocalizedString("Tap to reload config", comment: ""),
                  identifier:"postConfigFileChangeDetectionNotice")
    }
    
    func postStreamApiConnectFail(api:String) {
        self.post(title: "\(api) api connect error!",
            info: NSLocalizedString("Use reload config to try reconnect.", comment: ""))
    }
    
    func postConfigErrorNotice(msg:String) {
        let configName = ConfigManager.selectConfigName.count > 0 ? "\(ConfigManager.selectConfigName).yaml" : ""
        
        let message =  "\(configName): \(msg)"
        self.post(title: NSLocalizedString("Config loading Fail!", comment: ""), info: message)
    }
    
    
    func postSpeedTestBeginNotice() {
        self.post(title: NSLocalizedString("SpeedTest", comment: ""),
                  info: NSLocalizedString("SpeedTest has begun, please wait.", comment: ""))
    }
    
    func postSpeedTestingNotice() {
        self.post(title: NSLocalizedString("SpeedTest", comment: ""),
                  info: NSLocalizedString("SpeedTest is processing, please wait.", comment: ""))
    }
    
    func postSpeedTestFinishNotice() {
        self.post(title: NSLocalizedString("SpeedTest", comment: ""),
                  info: NSLocalizedString("SpeedTest Finished!", comment: ""))
    }
}

class UserNotificationCenterDelegate:NSObject,NSUserNotificationCenterDelegate {
    static let shared = UserNotificationCenterDelegate()
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        switch notification.userInfo?["identifier"] as? String {
        case "postConfigFileChangeDetectionNotice":
            NotificationCenter.default.post(Notification(name: kShouldUpDateConfig))
            center.removeAllDeliveredNotifications()
        default:
            break
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}
