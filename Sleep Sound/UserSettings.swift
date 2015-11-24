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
    let weekdayKey = "WDT";
    let weekendKey = "WNT";
    
    //create variables for storing times
    var weekdayTime: NSDate!;
    var weekendTime: NSDate!;
    
    
    
    init(){
        //set the time variables with stored data
        weekdayTime = getUserSettings(weekdayKey);
        weekendTime = getUserSettings(weekendKey);
       
    }
    
    func getUserSettings(key: String) ->NSDate!{
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