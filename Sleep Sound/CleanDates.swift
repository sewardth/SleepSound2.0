//
//  CleanDates.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/26/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import Foundation

class CleanDate {
    
    let calendar = NSCalendar.currentCalendar();
    
    var date:NSDate!;
    var formattedStringTime:String!;
    
    init(normalDate:NSDate){
        self.date = normalDate;
        self.formattedStringTime = formatDate(date);
        
    }
    
    private func formatDate(date:NSDate)->String{
        //convert NSDate object to string
        let formatter = NSDateFormatter();
        formatter.dateStyle = .NoStyle;
        formatter.timeStyle = .ShortStyle;
        
        return formatter.stringFromDate(date);
    }
    
    func getDateComponents()->NSDateComponents{
        //converts a NSDate to NSDateComponents
        
        let calendar = NSCalendar.currentCalendar();
        let components = calendar.components([.Hour, .Minute, .Weekday, .Year, .Month, .Day], fromDate: self.date);
        return components;
        
    }
    
    func covertComponentsToDate(components: NSDateComponents)->NSDate!{
        //receives NSDateComponents Object and converts to NSDate
        let components = components;
        components.second = 0;
        
        let date = calendar.dateFromComponents(components);
        return date;
    }
    
}