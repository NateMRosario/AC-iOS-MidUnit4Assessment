//
//  SettingViewController.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var settingTextField: UITextField!
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
         navigationController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserDefaultHelper.manager.setWinningNumber(to: Int(textField.text!)!)
        return true
    }

}
