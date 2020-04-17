//
//  DatePickerController.swift
//  Timer
//
//  Created by Antoine NICOT on 17/04/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {

    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var duration: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
   
    @IBAction func durationEdit(sender: AnyObject) {
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
    }
    
    @IBAction func durationOnClick(sender: AnyObject) {
        datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = datePicker.date
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.stringFromDate(date)
        
        
        
        start.text = formattedDate
        
        
        }


    @IBAction func dateSelectedFromDatePicker(_ : AnyObject) {
        let date = datePicker.date
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.stringFromDate(date)
        
        
        start.text = formattedDate
        end.text = formattedDate
        
        duration.text = String(datePicker.countDownDuration)
    }
    
}
