//
//  SettingsViewController.swift
//  Sleep Sound
//
//  Created by Thomas Seward on 11/22/15.
//  Copyright © 2015 Thomas Seward. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //fetch user settings
    var settings = userSettings();
    
    let calendar = NSCalendar.currentCalendar();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated);
        
        //create UI Labels
        self.createUI();
        
    }
    
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated);
        //save the weekday setting

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func formatDate(date:NSDate)->String{
        //convert NSDate object to string
        let formatter = NSDateFormatter();
        formatter.timeStyle = .ShortStyle;
        
        return formatter.stringFromDate(date);
    }
    
    
    func timeSet(sender:IdentifiedButton!){
        //recieves event trigger from button press
        
        print(sender.buttonIdentifier!);
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
            let title = self.formatDate(keyValue!);
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
