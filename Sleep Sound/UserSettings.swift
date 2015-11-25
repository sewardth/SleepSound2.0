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
    let storageKeys = ["Monday":"MON",
        "Tuesday":"TUE",
        "Wednesday":"WED",
        "Thursday":"THU",
        "Friday":"FRI",
        "Saturday":"SAT",
        "Sunday":"SUN"];
    
    
    //create dictionary variable for storing times
    var savedTimes = [String:NSDate!]();
    
    
    
    init(){
        //set the time variables with stored data using storage keys
        for (day, dayKey) in storageKeys{
            savedTimes.updateValue(getUserSettings(dayKey), forKey: day);
        }
       
    }
    
    private func getUserSettings(key: String) ->NSDate!{
        //create an instance of the default class
        let defaults = NSUserDefaults.standardUserDefaults();
        
        //query the stored user settings
        return defaults.valueForKey(key) as! NSDate!;

        
    }
    
    func setUserSettings(key: String, value: NSDate){
        //create an instance of the default class
        let defaults = NSUserDefaults.standardUserDefaults();
        
        //set value and store
        defaults.setValue(value, forKey: key)
        defaults.synchronize();
        
        print("Stored " + key);
        
    }
}