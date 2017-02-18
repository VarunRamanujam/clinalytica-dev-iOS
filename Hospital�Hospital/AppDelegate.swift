//
//  AppDelegate.swift
//  Hospital
//
//  Created by Shridhar on 1/30/17.
//
//

import UIKit
import IQKeyboardManagerSwift

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var hud: MBProgressHUD!
    var toastMessageHub: MBProgressHUD!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = FormBaseViewController(nibName: "FormBaseViewController", bundle: nil)
        let navVC = RUINavigationController()
        navVC.viewControllers = [firstVC]
        
//        let powerBI = PowerBIWebViewController(nibName: "PowerBIWebViewController", bundle: nil)
//        navVC.viewControllers = [powerBI]

        window?.rootViewController = navVC
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func showProgressHudForViewMy (withDetailsLabel:String!, labelText:String!)
    {
        DispatchQueue.main.async {
            self.hideProgressHudInView()
            self.hud = MBProgressHUD.showAdded(to: self.window, animated: true)
            self.hud.removeFromSuperViewOnHide = true
            self.hud.mode = MBProgressHUDMode.indeterminate
            self.hud.detailsLabelText = withDetailsLabel
            self.hud.labelText = labelText
        }
    }
    
    func hideProgressHudInView() {
        if self.hud != nil {
            self.hud.hide(true)
            self.hud = nil
        }
    }
    
    /*
     It shows message as toast.
     */
    func showMessageHudWithMessage(message:String, delay:CGFloat)
    {
        DispatchQueue.main.async {
            
            self.toastMessageHub = MBProgressHUD.showAdded(to: self.window, animated: true)
            self.toastMessageHub.removeFromSuperViewOnHide = true
            self.toastMessageHub.mode = MBProgressHUDMode.text
            let fontName = UIFont(name: "Avenir-Roman", size: 15.0)
            self.toastMessageHub.detailsLabelFont = fontName
            
            self.toastMessageHub.detailsLabelText = message as String
            let delay = TimeInterval(delay)
            self.toastMessageHub.hide(true, afterDelay: delay)
        }
    }

    /**
     Network Connectivity
     
     - returns: Network Connectiivity
     */
    func hasConnectivity() -> Bool {
        let reachability:Reachability = Reachability.forInternetConnection()
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        switch(networkStatus.rawValue){
        case 0:
            return false
            
        default:
            return true
            
        }
    }
}

