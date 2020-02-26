//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation
import UIKit
import Alamofire

import NYAlertViewController

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

//========== SERVER URL ==========//
let ServerIP = "http://a2api.credencetech.in/";
let UserRegister = "users/clientRegister";
let UserLogin = "users/login"
let UserResendOTP = "users/resendOTP"
let UserVerifyOTP = "users/verifyUser"

let GetSplashResponce = "splashData"
let GetAllPackagesByProductID = "users/packageList"

let UserPurchaseSubscriptionGenerateChecksum = "generate_checksum"
let UserPurchaseSubscriptionInsurtPayment = "users/addPayment"


//========== DEVELOPMENT SERVER URL ==========//
//let ServerIP = "http://192.168.9.101:8888/swift4demo/";

var dataManager = DataManager()

class DataManager : NSObject
{
    var appDelegate: AppDelegate?
    
    //NOTIFICATION REDIRECTION
    var boolIsAppOpenedFromNotification: Bool = false
    
    let reachability = Reachability()!
    
    var strServerMessage: String = ""
    
    //SPLASH
    var arrayAllCategories = [ObjCategory]()
    
    //PACKAGES
    var arrayPackages = [ObjPackage]()
    
    override init()
    {
        super.init()
        
        //        self.objLoggedInUser = User()
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    func showInternetNotConnectedError()
    {
        //METHOD 2
        let alertViewController = NYAlertViewController()
        
        // Set a title and message
        alertViewController.title = "No Internet Connection"
        alertViewController.message = "Please make sure that you are connected to the internet."
        
        // Customize appearance as desired
        alertViewController.view.tintColor = UIColor.white
        alertViewController.backgroundTapDismissalGestureEnabled = true
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.transitionStyle = NYAlertViewControllerTransitionStyle.fade
        
        alertViewController.titleFont = MySingleton.sharedManager().alertViewTitleFont
        alertViewController.messageFont = MySingleton.sharedManager().alertViewMessageFont
        alertViewController.buttonTitleFont = MySingleton.sharedManager().alertViewButtonTitleFont
        alertViewController.cancelButtonTitleFont = MySingleton.sharedManager().alertViewCancelButtonTitleFont
        
        // Add alert actions
        let okAction = NYAlertAction(
            title: "Go to Settings",
            style: .default,
            handler: { (action: NYAlertAction!) -> Void in
                AppDelegate.sharedInstance().window?.topMostController()?.dismiss(animated: true, completion: nil)
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
        })
        
        alertViewController.addAction(okAction)
        
        DispatchQueue.main.async {
            AppDelegate.sharedInstance().window?.topMostController()?.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func showAlertViewWithTitle(title: String, detail: String)
    {
        var strTitle : String = title
        var strDetails : String = ""
        
        if title == "Server Error" && (detail == nil || detail.count <= 0)
        {
            strDetails = "Oops! Something went wrong. Please try again later."
        }
        else if title == "Server Error" && (detail != nil || detail.count > 0)
        {
            strTitle = ""
            strDetails = detail
        }
        else
        {
            strDetails = detail
        }
        
        self.appDelegate?.dismissGlobalHUD()
        
        self.appDelegate?.showAlertViewWithTitle(title: strTitle, detail: strDetails)
    }
    
    func convertStringToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary as! [String : AnyObject]? as NSDictionary?
            } catch let error as NSError {
                var errorResponse = [String : AnyObject]()
                errorResponse["Error"] = "Issue" as AnyObject?
                print(error)
                return errorResponse as NSDictionary?
            }
        }
        return nil
    }
    
    func user_session_expired()
    {
        DispatchQueue.main.async(execute: {
            
            UserDefaults.standard.removeObject(forKey: "is_premiem")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "user_id")
            UserDefaults.standard.removeObject(forKey: "user_type")
            UserDefaults.standard.removeObject(forKey: "autologin")
            UserDefaults.standard.removeObject(forKey: "access_token")
            UserDefaults.standard.synchronize()
            
            let alertViewController = NYAlertViewController()
            
            // Set a title and message
            alertViewController.title = "Session Timeout"
            alertViewController.message = "Your session has been expired please login again to continue."
            
            // Customize appearance as desired
            alertViewController.view.tintColor = UIColor.white
            alertViewController.backgroundTapDismissalGestureEnabled = false
            alertViewController.swipeDismissalGestureEnabled = false
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
                                        
                    self.appDelegate!.window?.rootViewController? .dismiss(animated: true, completion: nil)
                    
                    //let viewController = User_LoginViewController()
                    //self.appDelegate!.navigationController!.pushViewController(viewController, animated: false)
            })
            
            alertViewController.addAction(okAction)
            
            self.appDelegate!.window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
            
        })
    }
        
    // MARK: - GET SPLSAH RESPONCE
    
    func getSplashResponce()
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            //appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, GetSplashResponce))!
            
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            
            let strUserID : String = UserDefaults.standard.value(forKey: "user_id") as? String ?? ""
            
            let strAccessToken : String = UserDefaults.standard.value(forKey: "access_token") as? String ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6bnVsbCwiZW1haWwiOm51bGwsInVzZXJ0eXBlIjpudWxsLCJpYXQiOjE1ODIxOTIwMjV9.daX_Xd50nbg2-yU30A_LAuY2_HYLWwEVvdMD3wmlems"
            
            let parameters = [
                "deviceID": strDeviceID,
                "deviceType": "1",
                "userID": strUserID
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue(strAccessToken, forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    let dictData: Dictionary<String, Any> = jsonResult["data"] as! Dictionary<String, Any>
                                    
                                    //CATEGORIES
                                    self.arrayAllCategories = [ObjCategory]()
                                    let arrayCategoryLocal = dictData["categoriesList"] as? NSArray
                                    if (arrayCategoryLocal != nil)
                                    {
                                        for objCategoryTemp in arrayCategoryLocal!
                                        {
                                            let objCategoryDictionary = objCategoryTemp as? NSDictionary
                                            
                                            let objNewCategory : ObjCategory = ObjCategory()
                                            objNewCategory .separateParametersForCategory(dictionary: objCategoryDictionary as! Dictionary<String, Any>)
                                            
                                            self.arrayAllCategories .append(objNewCategory)
                                        }
                                    }
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "getSplashResponceEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                            
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
        
    // MARK: - USER FUNCTION FOR REGISTRATION
    
    func user_Register(strName: String, strMobileNumber: String)
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, UserRegister))!
            
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            
            let parameters = [
                "deviceID": strDeviceID,
                "deviceType": "1",
                "name": strName,
                "mobileNumber": strMobileNumber
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6bnVsbCwiZW1haWwiOm51bGwsInVzZXJ0eXBlIjpudWxsLCJpYXQiOjE1ODIxOTIwMjV9.daX_Xd50nbg2-yU30A_LAuY2_HYLWwEVvdMD3wmlems", forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    let strUserID: String = "\(jsonResult["userID"] ?? "")"
                                    let strAccessToken: String = "\(jsonResult["accessToken"] ?? "")"
                                    
                                    UserDefaults.standard.setValue(strUserID, forKey: "user_id_temp")
                                    UserDefaults.standard.setValue(strAccessToken, forKey: "access_token_temp")
                                    UserDefaults.standard.setValue(strMobileNumber, forKey: "mobile_number_temp")
                                    UserDefaults.standard.synchronize()
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user_RegisterEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                            
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
        
    // MARK: - USER FUNCTION FOR LOGIN
    
    func user_Login(strMobileNumber: String)
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, UserLogin))!
            
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            
            let parameters = [
                "deviceId": strDeviceID,
                "deviceType": "1",
                "mobileNumber": strMobileNumber
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6bnVsbCwiZW1haWwiOm51bGwsInVzZXJ0eXBlIjpudWxsLCJpYXQiOjE1ODIxOTIwMjV9.daX_Xd50nbg2-yU30A_LAuY2_HYLWwEVvdMD3wmlems", forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    
                                    let strUserID: String = "\(jsonResult["userID"] ?? "")"
                                    let strAccessToken: String = "\(jsonResult["accessToken"] ?? "")"
                                    
                                    UserDefaults.standard.setValue(strUserID, forKey: "user_id_temp")
                                    UserDefaults.standard.setValue(strAccessToken, forKey: "access_token_temp")
                                    UserDefaults.standard.setValue(strMobileNumber, forKey: "mobile_number_temp")
                                    UserDefaults.standard.synchronize()
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user_LoginEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
        
    // MARK: - USER FUNCTION FOR LOGIN
    
    func user_ResendOTP()
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, UserResendOTP))!
            
            let strTempUserID : String = UserDefaults.standard.value(forKey: "user_id_temp") as? String ?? ""
            
            let parameters = [
                "userID": strTempUserID
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            //request.setValue(strAccessToken, forHTTPHeaderField: "jwt")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    self.appDelegate?.showAlertViewWithTitle(title: "", detail: self.strServerMessage)
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user_ResendOTPEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
        
    // MARK: - USER FUNCTION FOR LOGIN
    
    func user_VerifyOTP(strOTP: String)
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, UserVerifyOTP))!
            
            let strTempUserID : String = UserDefaults.standard.value(forKey: "user_id_temp") as? String ?? ""
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            let strDeviceToken : String = UserDefaults.standard.value(forKey: "device_token") as? String ?? ""
            
            let strTempAccessToken : String = UserDefaults.standard.value(forKey: "access_token_temp") as? String ?? ""
            
            let parameters = [
                "deviceID": strDeviceID,
                "deviceToken": strDeviceToken,
                "deviceType": "1",
                "userID": strTempUserID,
                "otp": strOTP
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue(strTempAccessToken, forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    let dictData: Dictionary<String, Any> = jsonResult["userDetail"] as! Dictionary<String, Any>
                                    
                                    let strUserID: String = "\(dictData["userID"] ?? "")"
                                    let strUserType: String = "\(dictData["usertype"] ?? "")"
                                    let strName: String = "\(dictData["name"] ?? "")"
                                    let strMobileNumber: String = "\(dictData["mobileNumber"] ?? "")"
                                    let strEmail: String = "\(dictData["email"] ?? "")"
                                    
                                    UserDefaults.standard.setValue("1", forKey: "is_logged_in")
                                    UserDefaults.standard.setValue(strUserID, forKey: "user_id")
                                    UserDefaults.standard.setValue( UserDefaults.standard.value(forKey: "access_token_temp"), forKey: "access_token")
                                    UserDefaults.standard.setValue(strUserType, forKey: "user_type")
                                    UserDefaults.standard.setValue(strName, forKey: "name")
                                    UserDefaults.standard.setValue(strMobileNumber, forKey: "mobile_number")
                                    UserDefaults.standard.setValue(strEmail, forKey: "email")
                                    //REMOVE TEMP IDS
                                    UserDefaults.standard.removeObject(forKey: "user_id_temp")
                                    UserDefaults.standard.removeObject(forKey: "access_token_temp")
                                    UserDefaults.standard.removeObject(forKey: "name_temp")
                                    UserDefaults.standard.removeObject(forKey: "mobile_number_temp")
                                    
                                    UserDefaults.standard.synchronize()
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user_VerifyOTPEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
        
    // MARK: - GET ALL PACKAGES BY PRODUCT
    
    func getAllPackagesByProduct(strProductID: String)
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            //appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, GetAllPackagesByProductID))!
            
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            
            let strAccessToken : String = UserDefaults.standard.value(forKey: "access_token") as? String ?? ""
            
            let parameters = [
                "deviceID": strDeviceID,
                "deviceType": "1",
                "productID": "0"//strProductID
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue(strAccessToken, forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    //CATEGORIES
                                    self.arrayPackages = [ObjPackage]()
                                    let arrayPackageLocal = jsonResult["packageList"] as? NSArray
                                    if (arrayPackageLocal != nil)
                                    {
                                        for objPackageTemp in arrayPackageLocal!
                                        {
                                            let objCategoryDictionary = objPackageTemp as? NSDictionary
                                            
                                            let objNewPackage : ObjPackage = ObjPackage()
                                            objNewPackage .separateParametersForPackage(dictionary: objCategoryDictionary as! Dictionary<String, Any>)
                                            
                                            self.arrayPackages .append(objNewPackage)
                                        }
                                    }
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "getAllPackagesByProductEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                            
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
            
    // MARK: - GET ALL PACKAGES BY PRODUCT
    
    func user_purchaseSubscriptionGenerateChecksum(strAmount: String)
    {
        if (reachability.whenReachable != nil && reachability.connection != .none)
        {
            //appDelegate?.showGlobalProgressHUDWithTitle(title: "Loading...")
            
            let urlComponents = NSURLComponents(string: String(format:"%@%@", ServerIP, UserPurchaseSubscriptionGenerateChecksum))!
            
            let strDeviceID : String = UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
            let strUserID : String = UserDefaults.standard.value(forKey: "user_id") as? String ?? ""
            
            let strAccessToken : String = UserDefaults.standard.value(forKey: "access_token") as? String ?? ""
            
            let parameters = [
                "deviceID": strDeviceID,
                "deviceType": "1",
                "userID": strUserID,
                "amount": strAmount
            ]
            
            print("\(urlComponents.url!)")
            
            //let strUrlString = String(format:"%@%@", ServerIP, URL_BROWSETAB_DATA)
            
            //var request = URLRequest(url: URL(string: strUrlString)!)
            var request = URLRequest(url: urlComponents.url!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.setValue(strAccessToken, forHTTPHeaderField: "accessToken")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                if let data = data {
                    do {
                        self.appDelegate?.dismissGlobalHUD()
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async(execute: {
                                
                                let strCode: String = "\(jsonResult["code"] ?? "0")"
                                
                                if(strCode == "100")
                                {
                                    self.strServerMessage = "\(jsonResult["message"] ?? "")"
                                    
                                    
                                    
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user_purchaseSubscriptionGenerateChecksumEvent"), object: self)
                                }
                                else
                                {
                                    let message: String = "\(jsonResult["message"] ?? "")"
                                    self.showAlertViewWithTitle(title: "", detail: message)
                                }
                            })
                            
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        let jsonStr = String(data: data, encoding: .utf8)
                        print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                        self.appDelegate?.dismissGlobalHUD()
                        self.showAlertViewWithTitle(title: "Server Error", detail: "")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    self.appDelegate?.dismissGlobalHUD()
                    self.showAlertViewWithTitle(title: "Server Error", detail: "")
                }
            })
            task.resume()
        }
        else
        {
            print("Connection not available. Please check your internet connection.")
            self.showInternetNotConnectedError()
        }
    }
}
