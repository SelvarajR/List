//
//  AppDelegate.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var newWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /* Assigning ViewController to the the app Window */
        if let window = newWindow {
            window.backgroundColor = .white
            window.rootViewController = UINavigationController(rootViewController: ViewController())
            window.makeKeyAndVisible()
        }
        return true
    }

}

