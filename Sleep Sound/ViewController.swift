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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check default user settings
        let settings = userSettings();
        print("here are the settings");
        print(settings);
        
        
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

