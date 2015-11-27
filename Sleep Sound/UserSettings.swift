//
//  UserSettings.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/22/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import Foundation

//create a structure for user settings
struct userSettings{
    
    //define storage keys
    let storageKeys = [2:"2-Monday",
        3:"3-Tuesday",
        4:"4-Wednesday",
        5:"5-Thursday",
        6:"6-Friday",
        7:"7-Saturday",
        1:"1-Sunday"];
    
    
    //create dictionary variable for storing times
    var savedTimes = [String:NSDate!]();
    
    
    
    init(){
        //set the time variables with stored data using storage keys
        for day in storageKeys.values{
            savedTimes.updateValue(getUserSettings(day), forKey: day);
        }
       
    }
    
    private func getUserSettings(key: String) ->NSDate!{
        //create an instance of the default class
        let defaults = NSUserDefaults.standardUserDefaults();
        
        //query the stored user settings
        return defaults.valueForKey(key) as! NSDate!;

        
    }
    
    func setUserSettings(key: String, value: NSDate!){
        //create an instance of the default class
        let defaults = NSUserDefaults.standardUserDefaults();
        
        //set value and store
        defaults.setValue(value, forKey: key)
        defaults.synchronize();
        
        print("Stored " + key + " : Value: " + String(value));
        
    }
}