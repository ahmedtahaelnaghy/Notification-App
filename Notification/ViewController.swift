//
//  ViewController.swift
//  Notification
//
//  Created by Ahmed Taha on 02/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var center: UNUserNotificationCenter!
    var isNotificationEnable: Bool = false
    var badge: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound]) { (userResponse, error) in

            switch userResponse {

                case true:
                    self.isNotificationEnable = true
                    
                case false:
                    self.isNotificationEnable = false
                
            }

            if let error = error {
                
                print(error.localizedDescription)

            }
        }
        
    }
    
    
    @IBAction func setReminderBtn(_ sender: Any) {
        
        if (isNotificationEnable == true) {
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder!"
            content.body = "You have a new message"
            content.sound = .default
            content.categoryIdentifier = "NotifiactionCategory"
            
            // UNTimeIntervalNotificationTrigger -> After specific time
            // UNCallendarNotificationTrigger
            // UNLocationNotificationTrigger

            let time = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: datePicker.date)
            let triggerTime = UNCalendarNotificationTrigger(dateMatching: time, repeats: false)

            let request = UNNotificationRequest(identifier: "RemiderNotification", content: content, trigger: triggerTime)
            
            let detailsAction = UNNotificationAction(identifier: "details", title: "Show Details", options: [.foreground])
            let skipAction = UNNotificationAction(identifier: "skip", title: "Skip", options: [])
            let category = UNNotificationCategory(identifier: "NotifiactionCategory", actions: [detailsAction, skipAction], intentIdentifiers: [], options: [])
            
            center.setNotificationCategories([category])
            
            center.add(request) { (error) in

                if let error = error {

                    print("Error is \(error)")

                }

            }
            
            
        }else {
            
            let alertController = UIAlertController(title: "Alert!", message: "Enable Notification From Settings", preferredStyle: .alert)
            let action = UIAlertAction(title: "oK", style: .cancel, handler: nil)
            
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
            
        }
           
    }
       
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
//        switch response.actionIdentifier {
//
//        case "details" :
//            print("details")
//
//        case "skip" :
//            print("Skip")
//
//        default:
//            break
//
//        }
        
        
        badge += 1
        self.tabBarController?.tabBar.items![1].badgeValue = "\(badge)"
        
        completionHandler()
          
    }
    
    // To show alert in ground (When app is openning)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        badge += 1
        
        self.tabBarController?.tabBar.items![1].badgeValue = "\(badge)"
        
        completionHandler([.alert, .sound])
        
    }
   
}
