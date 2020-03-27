//
//  PopUpController.swift
//  Timer
//
//  Created by Antoine NICOT on 20/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class PopUpController: UIViewController {

    
    var dataQuickTask = [String]()
    var dataQuickTaskTimer = [String]()
    var myDefaults = NSUserDefaults.standardUserDefaults()
    
    var identifierCell = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataQuickTask = myDefaults.stringArrayForKey("keyQuickTask3")!
        dataQuickTaskTimer = myDefaults.stringArrayForKey("keyQuickTaskTimer3")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CreateNewTask(sender: AnyObject) {
        
    }
    
    @IBAction func AddToTask(sender: AnyObject) {
    }
    
    
    @IBAction func Delete(sender: AnyObject) {
        dataQuickTask.removeAtIndex(identifierCell-10000)
        dataQuickTaskTimer.removeAtIndex(identifierCell-10000)
        
        myDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
        myDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
    }


}
