//
//  UserDefaultsViewController.swift
//  Notification
//
//  Created by Ahmed Taha on 10/04/2022.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    static var NAME_KEY = "userName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let name = textField.text!
        let userDefaults = UserDefaults.standard

        userDefaults.set(name, forKey: UserDefaultsViewController.NAME_KEY)

    }
    
    @IBAction func readBtn(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let name = userDefaults.string(forKey: UserDefaultsViewController.NAME_KEY)

        nameLbl.text = name
        
    }
     
}
