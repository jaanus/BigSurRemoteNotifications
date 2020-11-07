//
//  AppDelegate.swift
//  BigSurRemoteNotifications
//
//  Created by Jaanus Kase on 07.11.2020.
//

import Cocoa
import SwiftUI
import os.log
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let Log_appDelegate = OSLog(subsystem: "eu.delta8.BigSurRemoteNotifications", category: "App delegate")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        // register for remote notifications
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { [self] granted, error in
            
            if let error = error {
                os_log("Error requesting authorization: %@", log: Log_appDelegate, type: .error, String(describing: error))
            } else {
                os_log("Notification authorization ok, registering for remote notifications", log: Log_appDelegate, type: .default)
                DispatchQueue.main.async {
                    // Registering must be called on main queue
                    NSApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        os_log("Did register for remote notifications. Token length: %d", log: Log_appDelegate, type: .default, deviceToken.count)
    }
    
    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        os_log("Did fail to register for remote notifications. Error: %@", log: Log_appDelegate, type: .error, String(describing: error))
    }
}

