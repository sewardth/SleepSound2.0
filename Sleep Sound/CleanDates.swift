//
//  CleanDates.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/26/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import Foundation

class CleanDate {
    
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
    
}