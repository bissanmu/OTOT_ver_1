//
//  AppDelegate.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 9. 27..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //let locationManager = CLLocationManager()
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
        
        //beacon setting
        let uuidString = "24DDF411-8CF1-440C-87CD-E368DAF9C93E"
        let beaconIdentifier = "iBeaconModules.us"
        let beaconUUID:UUID = UUID(uuidString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
                                                         identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        
        //if(locationManager!.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization))) {
            locationManager!.requestAlwaysAuthorization()
        //}
        
        locationManager!.delegate = self
        //locationManager!.pausesLocationUpdatesAutomatically = false
        
        //locationManager!.startMonitoring(for: beaconRegion)
        //locationManager!.startRangingBeacons(in: beaconRegion)
        //locationManager!.startUpdatingLocation()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in }
        
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

extension AppDelegate : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }
        //manager.startRangingBeacons(in: region as! CLBeaconRegion)
        //anager.startUpdatingLocation()
        
        print("You entered the region")
        
        let content = UNMutableNotificationContent()
        content.title = "OTOT 테스트입니다. "
        content.body = "바디 테스트 입니다."
        content.sound = .default()
        
        let request = UNNotificationRequest(identifier: "OTOT_Ver_1", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            var beaconProximity: String;
            switch (beacon.proximity) {
            case CLProximity.unknown:    beaconProximity = "Unknown";
            case CLProximity.far:        beaconProximity = "Far";
            case CLProximity.near:       beaconProximity = "Near";
            case CLProximity.immediate:  beaconProximity = "Immediate";
            }
            print("BEACON RANGED: uuid: \(beacon.proximityUUID) major: \(beacon.major)  minor: \(beacon.minor) proximity: \(beaconProximity)")
        }
    }
}
