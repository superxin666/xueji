//
//  AppDelegate.swift
//  xueji
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundTask:UIBackgroundTaskIdentifier! = nil
    var avplayer: AVAudioPlayer? = nil
    var time : Timer!
    var timeNum2 : Int = 0



    //MARK: life circle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let login = UserDataManger.getLoginIdAndTokenInUD().isHaveLogin
        let token = UserDataManger.getLoginIdAndTokenInUD().tokenStr
        print("login\(login)")
        print("info\(token)")
        XJLog(message: token)
        if login == "1" {
            //显示主页
            self.tabCreat()
        } else {
            //显示登录注册页面
            self.showLogin()
        }

        let setCategoryErr : Error!

        do {
           let setCategoryErr = try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            print("后台播放失败")
        }

        do {
            let activationErr = try
                AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("后台播放激活失败")
        }

        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

//        UIApplication.shared.beginReceivingRemoteControlEvents()
//        let session : AVAudioSession = AVAudioSession.sharedInstance()
//        do {
//            let activationErr = try
//                session.setActive(true)
//        } catch {
//            print("后台播放激活失败")
//        }


    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.




//        十分钟
        let app = UIApplication.shared
        var bgTask : UIBackgroundTaskIdentifier!
        bgTask = app.beginBackgroundTask(expirationHandler: {
            DispatchQueue.main.async {
                if bgTask != UIBackgroundTaskInvalid{

                    bgTask = UIBackgroundTaskInvalid
                }
            }

            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    if bgTask != UIBackgroundTaskInvalid{
                        bgTask = UIBackgroundTaskInvalid
                    }

                }
            }

        })

        time = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(timeStart), userInfo: nil, repeats: true)


        //后台任务
//        if self.backgroundTask != nil {
//            application.endBackgroundTask(self.backgroundTask)
//            self.backgroundTask = UIBackgroundTaskInvalid
//        }
//        self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
//            application.endBackgroundTask(self.backgroundTask)
//            self.backgroundTask = UIBackgroundTaskInvalid
//        })
    }

    func timeStart() {
        timeNum2 = timeNum2 + 1
        if timeNum2 == 60 {
            self.tik()
            timeNum2 = 0
        }
    }


    func tik() {
        XJLog(message: "检测")
        XJLog(message: UIApplication.shared.backgroundTimeRemaining)
        if UIApplication.shared.backgroundTimeRemaining < 61 {
            let urlStr = Bundle.main.path(forResource: "timer", ofType: "mp3")
            let url  = URL(fileURLWithPath: urlStr!)
            weak var weakself = self
            do {
                weakself?.avplayer = try AVAudioPlayer(contentsOf: url)
            } catch _{
                weakself?.avplayer = nil
            }
            weakself?.avplayer?.play()

            UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        }
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
   //MARK: UI
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
    func showLogin()  {
        let loginVC = LogViewController()
        let nv :UINavigationController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = nv
        
    }

}

