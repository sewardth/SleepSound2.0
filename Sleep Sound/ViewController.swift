//
//  ViewController.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/22/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create button outlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //create time outlet
    @IBOutlet weak var timeLabel: UILabel!

    //create day label outlet
    @IBOutlet weak var dayLabel: UILabel!
    
    
    //check for saved user settings
    var settings = userSettings();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //use this to set AVAudio player
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        //update user settings
        settings = userSettings();
        
        //set background color
        self.view.backgroundColor = UIColor(red:0.19, green:0.19, blue:0.19, alpha:1.0);
        
        //add time function here
        let timeSetting = determineRunToTime();
        
        //set time label with set time
        timeLabel.text = timeSetting.0.formattedStringTime;
        
        //create day label
        let dayLabelValue = settings.storageKeys[timeSetting.1];
        
        //strip numbers from day
        let index = dayLabelValue!.startIndex.advancedBy(2);
        let daylabelTitle = dayLabelValue!.substringFromIndex(index);
        
        //set day label text
        dayLabel.text = daylabelTitle + " (" + timeSetting.2 + ")";
        
        
    }
    
    func determineRunToTime()->(CleanDate!, Int, String){
        //decides which time the user would like the sound to play to
        let today = NSDate();
        
        let cleanNow = CleanDate(normalDate: today); // gets a clean version of current date time
        
        //get current date components
        let cleanNowComponents = cleanNow.getDateComponents();
        
        let weekday = cleanNowComponents.weekday;
        
        //get saved date and convert to CleanDate with current date
        let savedDate = getSavedUserTime(weekday);
        let updatedSaveDate = updateSavedDate(savedDate!, currentDateComp: cleanNowComponents);
        
        //if saved date time is less than now, return that setting.  Otherwise, return the next setting.  
        if updatedSaveDate.timeIntervalSince1970 > today.timeIntervalSince1970 {
            return (CleanDate(normalDate: updatedSaveDate), weekday, "today");
        } else{
            //checks if end of week.  If so, set weekday to 1.
            if weekday == 7{
                return (CleanDate(normalDate: getSavedUserTime(1)), 1, "tomorrow");
            }else{
                return (CleanDate(normalDate: getSavedUserTime(weekday + 1)), weekday + 1 , "tomorrow");
            }
            
        }
    }
    
    func getSavedUserTime(weekday: Int)->NSDate!{
        //receives a weekday integer and queries the saved user setting
        let lookupKey = settings.storageKeys[weekday];
        let savedDate = settings.savedTimes[lookupKey!];
        
        return savedDate;
    }
    
    func updateSavedDate(savedDateComp: NSDate!, currentDateComp: NSDateComponents!)->NSDate!{
        //updates saved date with current date parts.  Time remains unchanged
        
        //get saved date as a clean date
        let savedDate = CleanDate(normalDate: savedDateComp);
        let savedDateComponents = savedDate.getDateComponents();
        
        //Update savedDate with current date
        savedDateComponents.year = currentDateComp.year;
        savedDateComponents.month = currentDateComp.month;
        savedDateComponents.day = currentDateComp.day;
        
        //convert saved date back to NSDate
        let updatedSavedDate = savedDate.covertComponentsToDate(savedDateComponents);
        return updatedSavedDate;
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func startSound(sender: UIButton) {
        //hide start button and display stop
        buttonSwap();
    }
    
    

    @IBAction func stopSound(sender: UIButton) {
        //hide stop button and display start
        buttonSwap();
    }
    
    
    func buttonSwap(){
        //method to swap start and stop buttons
        if startButton.hidden == false{
            //hides start button and shows stop
            startButton.hidden = true;
            startButton.enabled = false;
            stopButton.enabled = true;
            stopButton.hidden = false;
            
        }else{
            //hides stop button and shows start
            stopButton.enabled = false;
            stopButton.hidden = true;
            startButton.enabled = true;
            startButton.hidden = false;
        }
    }
    
}

