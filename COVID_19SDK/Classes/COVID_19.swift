//
//  COVID_19.swift
//  COVID_19
//
//  Created by Muhammad Alkhalaf on 18.03.2020.
//  Copyright © 2020 Medrics. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
import CoreLocation

@available(iOS 10.0, *)
public class COVID_19 {
    
    private static let COVID_19_NOTIFICATION_ID = "COVID_19_NOTIFICATION_ID"
    private static var patientShouldBeTracked = false
    
    private init(){}
    
    public static func initialize(){
        //Call Api request
        //Json Response : send or don't send local notification
        //                patient should be tracked or shouldn't be tracked
        //when open local notification -> open external website
        sendLocalNotification()//for test
        patientShouldBeTracked = true//for test
    }
    
    private static func sendLocalNotification(){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Coronavirus disease (COVID-19)"
        content.body = "We strongly recommend that you examine yourself"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier:COVID_19_NOTIFICATION_ID,content:content,trigger:trigger)
        center.add(request)
    }
    
    public static func userNotificationCenter(application: UIApplication,didReceive response: UNNotificationResponse){
        let identifier = response.notification.request.identifier
        if identifier == COVID_19_NOTIFICATION_ID{
            if let url = URL(string:"https://www.saglik.gov.tr/") {
                application.open(url,options:[:],completionHandler:nil)
            }
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 3){
            UIControl().sendAction(#selector(NSXPCConnection.suspend),to:application, for: nil)
        }
    }
    
    public static func sendCurrentLocation(location:CLLocation){
        if patientShouldBeTracked{
            //send location to server
        }
    }
}
