//
//  CustomTableViewCell.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePausePlay: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var boutonBrochure: UIButton!
    
    @IBAction func OnClick(sender: AnyObject) {
        if(!segueBrochure){
            segueBrochure = true
        }
    }
    
    var timer = NSTimer()
    var chrono : Int = 0
    var oneTimer = true
    var segueBrochure = false
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func activerTimer(){
        
        if(oneTimer){
            self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
            labelTimer.textColor = UIColor.redColor()
            imagePausePlay.image = UIImage(named: "ImagePauseRouge")
            
        }
        
        else if(!oneTimer){
            oneTimer = true
            self.timer.invalidate()
            labelTimer.textColor = UIColor.darkTextColor()
            imagePausePlay.image = UIImage(named: "ImageTriangle")
        }
        
    }
    
    internal func incrementer(){
        
        chrono += 1
        labelTimer.text = String(chrono)
        
    }
}
