//
//  Utils.swift
//  Call Inspector
//
//  Created by Jurica Mlinaric on 26/10/2018.
//  Copyright © 2018 Jurica Mlinaric. All rights reserved.
//

import Foundation

enum Gender {
    case Male
    case Female
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

public class Utils {
    
    // I wasn't really sure what is the correct format for given numbers to recognize as scam or suspicios calls. The best way to se sure is to add them manually
    
    public static func initializeBlockingNumbers() {
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        
        guard (defaults!.array(forKey: Constants.BLOCKED_NUMBERS) != nil) else {
            let arr: [String] = ["​2539501212​"]
            defaults!.set(arr, forKey: Constants.BLOCKED_NUMBERS)
            return
        }
    }
    
    public static func initializeIdentiyingNumbers() {
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        
        guard (defaults!.array(forKey: Constants.ID_NUMBERS) != nil) else {
            let arr: [String] = ["4259501212"]
            defaults!.set(arr, forKey: Constants.ID_NUMBERS)
            return
        }
    }
    
    public static func initializeFilteredNumbers() {
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        
        guard (defaults!.array(forKey: Constants.SMS_FILTERED_NUMBERS) != nil) else {
            let arr: [String] = ["2539501212", "4259501212"]
            defaults!.set(arr, forKey: Constants.SMS_FILTERED_NUMBERS)
            return
        }
    }
    
    public static func getIdNumbers() -> [String] {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        let arr = defaults?.array(forKey: Constants.ID_NUMBERS)
        
        return arr as! [String]
    }
    
    public static func getBlockNumbers() -> [String] {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        let arr = defaults?.array(forKey: Constants.BLOCKED_NUMBERS)
        
        return arr as! [String]
    }
    
    public static func getFilteredNumbers() -> [String] {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        let arr = defaults?.array(forKey: Constants.SMS_FILTERED_NUMBERS)
        
        return arr as! [String]
    }
    
    public static func saveBlockingNumber(number: String) {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        var blockedNumbers = defaults!.array(forKey: Constants.BLOCKED_NUMBERS)
        
        blockedNumbers?.append(number)
        defaults!.set(blockedNumbers, forKey: Constants.BLOCKED_NUMBERS)
    }
    
    public static func saveIdentifyingNumber(number: String) {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        var identifyingNumbers = defaults!.array(forKey: Constants.ID_NUMBERS)
        
        identifyingNumbers?.append(number)
        defaults!.set(identifyingNumbers, forKey: Constants.ID_NUMBERS)
    }
    
    public static func saveFilteringNumber(number: String) {
        
        let defaults = UserDefaults(suiteName: Constants.USER_DEFAULTS)
        var identifyingNumbers = defaults!.array(forKey: Constants.SMS_FILTERED_NUMBERS)
        
        identifyingNumbers?.append(number)
        defaults!.set(identifyingNumbers, forKey: Constants.SMS_FILTERED_NUMBERS)
    }
    
}
