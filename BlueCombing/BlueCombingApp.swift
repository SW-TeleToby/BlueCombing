//
//  BlueCombingApp.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import SwiftUI
import Firebase
import FacebookCore

@main
struct BlueCombingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                
                ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
                    
                FirebaseApp.configure()
                
                return true
            }
            
            
            func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
                
                ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
            }
        }
}
