//
//  CallDirectoryHandler.swift
//  CallExtensionHandler
//
//  Created by Jurica Mlinaric on 26/10/2018.
//  Copyright © 2018 Jurica Mlinaric. All rights reserved.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        
        let phoneNumbersToBlock = Utils.getBlockNumbers()
        
        for phoneNumber in phoneNumbersToBlock {
            context.addBlockingEntry(withNextSequentialPhoneNumber: CXCallDirectoryPhoneNumber(phoneNumber)!)
        }
        
        let phoneNumbersToIdentify = Utils.getIdNumbers()
        
        for phoneNumber in phoneNumbersToIdentify {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: CXCallDirectoryPhoneNumber(phoneNumber)!, label: "Ex Girlfriend")
        }
        
        context.completeRequest { (suc) in
            print(suc)
        }
    }
}
