//
//  SettingsViewController.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/22/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //outlets for date pickers
    @IBOutlet weak var weekdayPicker: UIDatePicker!
    @IBOutlet weak var weekendPicker: UIDatePicker!
    
    
    
    //fetch user settings
    var settings = userSettings();
    
    let calendar = NSCalendar.currentCalendar();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated);
 
        
        //if weekday setting exists, set weekday picker to that time
        if let weekday = settings.weekdayTime{
            let date = calendar.dateFromComponents(weekday);
            weekdayPicker.setDate(date!, animated: true);
        }
        
        //if weekend date setting exists, set weekday picker to that time
        if let weekend = settings.weekendTime{
            let date = calendar.dateFromComponents(weekend);
            weekendPicker.setDate(date!, animated: true);
        }
        
    }
    
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated);
        //save the weekday setting
        settings.setUserSettings(settings.weekdayKey, value: settings.weekdayTime);
        
        //save the weekend setting
        settings.setUserSettings(settings.weekendKey, value: settings.weekendTime);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func setWeekday(sender: UIDatePicker) {
        
        //get datepicker date and convert to components
        let date = weekdayPicker.date;
        let components = calendar.components([.Year,.Month,.Day,.Hour,.Minute], fromDate:date);
        
        //set user default
        settings.weekdayTime = components;
        
    }
    
    
    
    @IBAction func setWeekend(sender: UIDatePicker) {
        //get datepicker date and convert to components
        let date = weekendPicker.date;
        let components = calendar.components([.Year,.Month,.Day,.Hour,.Minute], fromDate:date);
        
        //set user default
        settings.weekendTime = components;
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
