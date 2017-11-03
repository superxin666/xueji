//
//  AppDelegate.swift
//  xueji
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.tabCreat()
        return true
    }
    func tabCreat() {
        
        //学习
        let stVc : StudyViewController = StudyViewController()
        let stNv : UINavigationController = UINavigationController(rootViewController: stVc)
        let iteam1 : UITabBarItem = UITabBarItem(title: "学习", image: #imageLiteral(resourceName: "study_tab_normal"), selectedImage:#imageLiteral(resourceName: "study_tab_selected"))
        stNv.tabBarItem = iteam1;
        //复习
        let reVc : ReviewViewController = ReviewViewController()
        let reNv : UINavigationController = UINavigationController(rootViewController: reVc)
        let iteam3 : UITabBarItem = UITabBarItem(title: "复习", image: #imageLiteral(resourceName: "review_tab_normal"), selectedImage: #imageLiteral(resourceName: "review_tab_selected"))
        reNv.tabBarItem = iteam3;
        
        //个人
        let usVc : UserViewController = UserViewController()
        let usNv : UINavigationController = UINavigationController(rootViewController: usVc)
        let iteam4 : UITabBarItem = UITabBarItem(title: "个人", image: #imageLiteral(resourceName: "user_tab_normal"), selectedImage: #imageLiteral(resourceName: "user_tab_selected"))
        usNv.tabBarItem = iteam4;
        
        let vcArr = [stNv,reNv,usNv]
        let tab: UITabBarController = UITabBarController()
        tab.viewControllers = vcArr;
        tab.tabBar.barTintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:black_53, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:blue_tab_selected, forKey:NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject], for:UIControlState.selected)
        self.window?.rootViewController = tab
        
        
        
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

