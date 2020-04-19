//
//  DatePickerController.swift
//  Timer
//
//  Created by Antoine NICOT on 17/04/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit


class DatePickerController: UIViewController {

    var startTxt = ""
    var endTxt = ""
    var durationTxt = ""
    
    var startBool = false
    var endBool = false
    var durationBool = false
    
    var previousDateStart = NSDate()
    
    var previousDateEnd = NSDate()
    
    
    
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var duration: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
   
    @IBAction func durationEdit(sender: AnyObject) { // au relachement du click
        durationBool = false
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
    }
    
    @IBAction func durationOnClick(sender: AnyObject) {
        durationBool = true
        datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
       
        
    }
  
    
    @IBAction func startOnClick(sender: AnyObject) {
        
        startBool = true
    }
    
    @IBAction func endOnClick(sender: AnyObject) {
        
        endBool = true
        
    }
    
    @IBAction func startFinish(sender: AnyObject) {
        datePicker.setDate(previousDateEnd, animated: true)
        startBool = false
        
    }
    
    @IBAction func endFinish(sender: AnyObject) {
        datePicker.setDate(previousDateStart, animated: true)
        endBool = false
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }


    @IBAction func dateSelectedFromDatePicker(_ : AnyObject) {
        let date = datePicker.date
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = format.stringFromDate(date)
        
        if(startBool){
            
            start.text = formattedDate
            previousDateStart = datePicker.date
            
        }
        if(endBool){
            
            end.text = formattedDate
            previousDateEnd = datePicker.date
            
        }
        if(durationBool){
            let entier = floor(datePicker.countDownDuration/3600)
            let decimal = ((datePicker.countDownDuration/3600 - floor(datePicker.countDownDuration/3600)) * 60)/100
            duration.text =  String(entier + decimal)
         
        }
        
        
        
        
    }
    
    
    
}
