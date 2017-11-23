//
//  AppDelegate.swift
//  BeerTracker
//
//  Created by Doron Katz.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var database: CBLDatabase!
    var remoteSyncURL: NSURL?
    var syncError: NSError?
    
    var pull: CBLReplication?
    var push: CBLReplication?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do{
            try self.database = CBLManager.sharedInstance().databaseNamed(Global.kDatabaseName)
        }catch let error as NSError {
            NSLog("Cannot close database: %@", error)
        }
        
        setupPushAndPull()
        
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


}

extension AppDelegate{
    ///MARK: Initialize bidirectional continuous sync:
    func setupPushAndPull(){
        self.pull = database.createPullReplication(Global.kServerDbURL)
        self.push = database.createPushReplication(Global.kServerDbURL)
        pull?.continuous = true
        push?.continuous = true
        
        // Observe replication progress changes, in both directions:
        NotificationCenter.default.addObserver(self, selector: #selector(replicationProgress(notification:)),
                                               name: NSNotification.Name.cblReplicationChange, object: pull)

        NotificationCenter.default.addObserver(self, selector: #selector(replicationProgress(notification:)),
                                               name: NSNotification.Name.cblReplicationChange, object: push)
        
        push?.start()
        pull?.start()
    }
    
    func replicationProgress(notification: NSNotification){
        UIApplication.shared.isNetworkActivityIndicatorVisible =
            (push?.status == .active || pull?.status == .active)
        
        let error = push?.lastError as? NSError;
        if (error != syncError) {
            syncError = error
            if let errorCode = error?.code {
                NSLog("Replication Error: \(error!)")
                if errorCode == 401 {
                    print("Authentication error. username or password not correct")
                    
                }
            }
        }
    }
}


