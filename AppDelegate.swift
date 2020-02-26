//
//  AppDelegate.swift
//  A2-Milk
//
//  Created by Dipen on 25/01/20.
//  Copyright © 2020 A2Milk. All rights reserved.
//

import UIKit
import MBProgressHUD
import NYAlertViewController
import IQKeyboardManagerSwift
import SwiftKeychainWrapper

let objCommonUtility: CommonUtility = CommonUtility()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    
    class func sharedInstance() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = false
        
        let retrievedDeviceUUID: String? = KeychainWrapper.standard.string(forKey: "device_id")
        
        if(retrievedDeviceUUID != nil)
        {
            print("UUID: \(retrievedDeviceUUID)")
            UserDefaults.standard.set(retrievedDeviceUUID, forKey: "device_id")
            UserDefaults.standard.synchronize()
        }
        else
        {
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            print("UUID: \(uuid)")
            UserDefaults.standard.set(uuid, forKey: "device_id")
            
            let saveSuccessful: Bool = KeychainWrapper.standard.set(uuid, forKey: "device_id")
            print("Save was successful: \(saveSuccessful)")
        }
        UserDefaults.standard.synchronize()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        
        let viewController: Common_SplashViewController = Common_SplashViewController()
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        //DISABLE DARK MODE
        if #available(iOS 12.0, *) {
            if #available(iOS 13.0, *) {
                self.window!.overrideUserInterfaceStyle = .light
            } else {
                       // Fallback on earlier versions
                   }
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
                
        self.window?.endEditing(true)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "applicationDidEnterBackgroundEvent"), object: self)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "applicationWillEnterForegroundEvent"), object: self)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Other Methods
    
    func showAlertViewWithTitle(title: String, detail: String)
    {
        let alertViewController = NYAlertViewController()
        
        // Set a title and message
        alertViewController.title = title
        alertViewController.message = detail
        
        // Customize appearance as desired
        alertViewController.view.tintColor = UIColor.white
        alertViewController.backgroundTapDismissalGestureEnabled = true
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.transitionStyle = NYAlertViewControllerTransitionStyle.fade
        
        alertViewController.titleFont = MySingleton.sharedManager().alertViewTitleFont
        alertViewController.messageFont = MySingleton.sharedManager().alertViewMessageFont
        alertViewController.buttonTitleFont = MySingleton.sharedManager().alertViewButtonTitleFont
        alertViewController.cancelButtonTitleFont = MySingleton.sharedManager().alertViewCancelButtonTitleFont
        
        alertViewController.buttonColor = MySingleton.sharedManager().alertViewLeftButtonBackgroundColor
        
        // Add alert actions
        let okAction = NYAlertAction(
            title: "Ok",
            style: .default,
            handler: { (action: NYAlertAction!) -> Void in
                
                DispatchQueue.main.async {
                    
                    self.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
        })
        
        alertViewController.addAction(okAction)
                
        DispatchQueue.main.async {

            self.window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func showGlobalProgressHUDWithTitle(title: String)
    {
        DispatchQueue.main.async {
            //let app = UIApplication.shared.delegate as? AppDelegate
            //let window = app?.window
            
            MBProgressHUD.hide(for: self.window!, animated: true)
            
            let hud = MBProgressHUD.showAdded(to: self.window!, animated: true)
            hud.mode = MBProgressHUDMode.indeterminate
            hud.label.text = title
            hud.dimBackground = true
        }
    }
    
    func dismissGlobalHUD()
    {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.window!, animated: true)
        }
    }
}

