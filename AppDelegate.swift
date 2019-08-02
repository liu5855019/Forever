//
//  AppDelegate.swift
//  Forever
//
//  Created by iMac-03 on 2019/7/29.
//  Copyright © 2019 daimu. All rights reserved.
//

import UIKit

import IQKeyboardManagerSwift
import Toast_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        
//        if user.token?.count ?? 0 > 0 {
//            login();
//        } else {
//            logout();
//        }
        
        login();
        
        window?.makeKeyAndVisible();
        
        configIQKeyboard();
        configToast();
        
        return true;
    }
    
    //MARK: - LOGIN / LOGOUT
    
    func login()
    {
        let vc = HomeVC();
        let navc = DMBaseNavigationController.init(rootViewController: vc);
        window?.rootViewController = navc;
    }
    
    func logout() {
        user.token = "";
        user.write();
        let vc = LoginVC();
        let navc = DMBaseNavigationController.init(rootViewController: vc);
        window?.rootViewController = navc;
    }
    
    func animateLogout(_ isOverdue:Bool?) {
        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.logout();
        }) { (done) in
            if isOverdue ?? false {
                self.window?.makeToast("登录信息已过期,请重新登录");
            }
        }
    }
    
    //MARK: - CONFIG
    
    func configIQKeyboard() -> Void {
        IQKeyboardManager.shared.enable = true;
        IQKeyboardManager.shared.keyboardDistanceFromTextField = CGFloat(kScaleW(10));
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true;
    }
    
    func configToast() -> Void {
        ToastManager.shared.position = .center;
        ToastManager.shared.duration = 2.5;
        ToastManager.shared.isQueueEnabled = true;
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


}

