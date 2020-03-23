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
    var dataQuickTaskDefaults = NSUserDefaults.standardUserDefaults()
    var dataQuickTaskTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    var cellAppelante = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataQuickTask = dataQuickTaskDefaults.stringArrayForKey("keyQuickTask3")!
        dataQuickTaskTimer = dataQuickTaskTimerDefaults.stringArrayForKey("keyQuickTaskTimer3")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CreateNewTask(sender: AnyObject) {
        print(sender)
    }
    
    @IBAction func AddToTask(sender: AnyObject) {
    }
    
    
    @IBAction func Delete(sender: AnyObject) {
        
        
    }


}
