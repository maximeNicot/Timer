//
//  ViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 01/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quickStart: UIButton!
    @IBOutlet weak var labelTimer: UILabel!

    var timer = NSTimer()
    var chrono : Int = 0
    var oneTimer = true
    
    @IBAction func quickStartAction(sender: AnyObject) {
        
        
        if(oneTimer){
        self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
        }
        
    }
    
    @IBOutlet weak var pause: UIButton!
    @IBAction func pause(sender: AnyObject) {
        oneTimer = true
        timer.invalidate()
    }
    
    @IBAction func stop(sender: AnyObject) {
        chrono = 0
        labelTimer.text = String(chrono)
        oneTimer = true
        timer.invalidate()
    }
    
    internal func incrementer(){
        chrono += 1
        labelTimer.text = "\(chrono)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

