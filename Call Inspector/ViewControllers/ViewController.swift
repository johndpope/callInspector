//
//  ViewController.swift
//  Call Inspector
//
//  Created by Jurica Mlinaric on 26/10/2018.
//  Copyright © 2018 Jurica Mlinaric. All rights reserved.
//

import UIKit
import CallKit
import IdentityLookup

class ViewController: UIViewController, CXCallObserverDelegate {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var callObserver: CXCallObserver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callObserver = CXCallObserver()
        callObserver.setDelegate(self, queue: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(checkForStatus), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        
        Utils.initializeBlockingNumbers()
        Utils.initializeIdentiyingNumbers()
        Utils.initializeFilteredNumbers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkForStatus()
    }

    // Call observer delegate methods
    // This was an attempt of capturing incoming call's phone number
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded == true {
            print("CXCallState :Disconnected")
        }
        if call.isOutgoing == true && call.hasConnected == false {
            print("CXCallState :Dialing")
        }
        if call.isOutgoing == false && call.hasConnected == false && call.hasEnded == false {
            print("CXCallState :Incoming")
            
        }
        if call.hasConnected == true && call.hasEnded == false {
            print("CXCallState : Connected")
        }
    }
    
    // Private methods
    @objc private func checkForStatus() {
        CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: "hr.calldirectory.hr.CallDirectoryExtension", completionHandler: { (status, error) -> Void in
        
            if status == CXCallDirectoryManager.EnabledStatus.enabled {
                self.setCallBlokcing()
            } else {
                DispatchQueue.main.async {
                    self.infoLabel.text = "To enable Call Inspector's features: \n\n1. Open Settings \n2. Phone \n3. Call Blocking & Identification \n4. Enable Call Inspector \n\nThank you!"
                    self.indicator.stopAnimating()
                }
            }
        })
    }
    
    private func setCallBlokcing(){
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "hr.calldirectory.hr.CallDirectoryExtension", completionHandler: { (error) -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self.infoLabel.text = "Something went wrong, please check your settings and restart your app!"
                    self.indicator.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.infoLabel.text = "Click on ADD NUMBERS to continue to use all the great features!"
                    self.btnAdd.isHidden = false
                    self.indicator.stopAnimating()
                }
            }
        })
    }
}

