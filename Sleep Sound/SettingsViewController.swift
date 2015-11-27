//
//  SettingsViewController.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/22/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //set initial variable for UIDatePicker
    var datePickHolder:IdentifiedUIDatePicker!;
    
    
    //fetch user settings
    var settings = userSettings();
    
    let calendar = NSCalendar.currentCalendar();

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated);
        
        //create UI Labels
        createUI();
        
    }
    
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated);
        //save the changed settings
        for key in settings.savedTimes.keys{
            let value = settings.savedTimes[key];
            settings.setUserSettings(key, value: value!);
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveTime(sender:IdentifiedUIDatePicker){
        
        //get key value
        let keyValue = sender.pickerKey;
        
        //get picker time
        let dateTime = sender.date;
        
        //set and save value
        settings.savedTimes[keyValue!] =  dateTime;
        
        //reset button
        //get clean time
        let buttonTime = CleanDate(normalDate: dateTime).formattedStringTime;
        sender.buttonSender!.backgroundColor = UIColor.greenColor();
        sender.buttonSender!.setTitle(buttonTime, forState: UIControlState.Normal);
        
        
    }
    
    
    
    
    func timeSet(sender:IdentifiedButton!){
        //recieves event trigger from button press
        
        //check if a current date picker exists.  If so, clear before creating new.
        if datePickHolder != nil{
            datePickHolder.removeFromSuperview();
            
        }
        
        //create date picker
        let datePicker = createUIPicker(sender.buttonIdentifier!);
        
        //append button to picker
        datePicker.buttonSender = sender;
        
        //display picker
        self.view.addSubview(datePicker);
        
        //store datePickHolder in global varible
        datePickHolder = datePicker;
        
    }
    
    
    func createUIPicker(key: String)->IdentifiedUIDatePicker{
        //create a UI Date picker with time only
        let datePicker = IdentifiedUIDatePicker(frame: CGRectMake(10, 400,  300,  150));
        datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor");
        datePicker.datePickerMode = UIDatePickerMode.Time;
        datePicker.pickerKey = key;
        datePicker.addTarget(self, action: "saveTime:", forControlEvents: UIControlEvents.ValueChanged);
        
        //check for saved time
        let savedTime = settings.savedTimes[key];
        
        //if saved time, set UI picker to saved value.
        if savedTime! != nil{
            datePicker.setDate(savedTime!, animated: false);
        }
        
        return datePicker;
    }
    
    
    func createLabel(labelTitle:String, startingHeight:CGFloat ){
        //create labels
        let label = UILabel();
        label.frame = CGRectMake(50,startingHeight,100,21);
        label.textColor = UIColor.whiteColor();
        label.backgroundColor = UIColor.blackColor();
        label.text = labelTitle;
        label.font = UIFont.boldSystemFontOfSize(16.0);
        
        //add label to the view
        self.view.addSubview(label);
        
    }
    
    
    func createButton(key: String, keyValue:NSDate?, startingHeight:CGFloat){
        
        //create button
        let button = IdentifiedButton(frame: CGRectMake(175, startingHeight, 125, 30));
        button.buttonIdentifier = key;
        button.addTarget(self, action: "timeSet:", forControlEvents: UIControlEvents.TouchUpInside);
        
        //if value is blank set color to red and text to "-"
        if keyValue != nil{
            button.backgroundColor = UIColor.greenColor();
            
            //set time label
            let title = CleanDate(normalDate: keyValue!).formattedStringTime;
            button.setTitle(title, forState: UIControlState.Normal);
        }
        else{
            button.backgroundColor = UIColor.redColor();
            button.setTitle("-", forState: UIControlState.Normal);
            
        }
        //add button to the view
        self.view.addSubview(button);
        
    }
    
    
    func createUI(){
        //create labels based on keys in dictionary
        
        //set the starting height for the labels
        var startingHeight: CGFloat = 100.0;
        
        //sort the dictionary keys in an arry
        let sortedKeys = Array(settings.savedTimes.keys).sort();
        
        //iterate the array and build labels
        for day in sortedKeys{
            
            //strip numbers from day
            let index = day.startIndex.advancedBy(2);
            let labelTitle = day.substringFromIndex(index);
            
            //create labels
            createLabel(labelTitle, startingHeight: startingHeight);
            
            //create buttons
            //get value
            let value = settings.savedTimes[day];
            createButton(day, keyValue: value!, startingHeight: startingHeight);
            
            
            //increment height
            startingHeight =  startingHeight + 45.0;
            
        }
        

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
