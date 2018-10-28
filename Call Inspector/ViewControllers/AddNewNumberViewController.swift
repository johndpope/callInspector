//
//  AddNewNumberViewController.swift
//  Call Inspector
//
//  Created by Jurica Mlinaric on 26/10/2018.
//  Copyright © 2018 Jurica Mlinaric. All rights reserved.
//

import UIKit

class AddNewNumberViewController: UIViewController {
    
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var numberTxt: UITextField!
    @IBOutlet weak var blockSwitch: UISwitch!
    @IBOutlet weak var identifySwitch: UISwitch!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add new number"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addNumber))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func blockSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            identifySwitch.setOn(false, animated: true)
        }
    }
    
    @IBAction func identifySwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            blockSwitch.setOn(false, animated: true)
        }
    }
    
    // Private methods
    
    @objc private func addNumber(sender: UIBarButtonItem) {
        if checkPhoneNumber() {
            
            let number: String = "+" + countryCodeTxt.text! + numberTxt.text!
            
            if blockSwitch.isOn {
                Utils.saveBlockingNumber(number: number)
            }
            
            if identifySwitch.isOn {
                Utils.saveIdentifyingNumber(number: number)
            }
            
            if filterSwitch.isOn {
                Utils.saveFilteringNumber(number: number)
            }
            
            self.navigationController?.popViewController(animated: true)
            
        } else {
            showAlert(title: "Incorrect phone number. Please try again!")
        }
    }
    
    private func checkPhoneNumber() -> Bool {
        if countryCodeTxt.text != "" && numberTxt.text != "" {
            let number: String = "+" + countryCodeTxt.text! + numberTxt.text!
            return number.isPhoneNumber
        } else {
            showAlert(title: "Please fill out all the fields!")
        }
        
        return false
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
