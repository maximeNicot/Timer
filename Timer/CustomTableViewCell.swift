//
//  CustomTableViewCell.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit
import Foundation


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePausePlay: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var boutonBrochure: UIButton!
    
    
    var delegate:CellDelegate!
    var identifier = 1
    var myDefaults = NSUserDefaults.standardUserDefaults()
   
    var timer = NSTimer()
    var chrono : Int = 0
    var oneTimer = true
    
    var isPageBlanche = false
    var isDossier = false
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
        labelTimer.text = String(chrono)
    }
    
    //click sur le bouton a droite des cells
    @IBAction func OnClick(sender: AnyObject) {
        self.delegate.SegueFromCell(mydata: identifier)
         
    }
    
    func starter(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        labelTimer.text = String(chrono)
    }

    override func setSelected(selected: Bool, animated: Bool) {
       
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
    func activerTimer(){
        
        if(oneTimer){
            self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
            labelTimer.textColor = UIColor.redColor()
            if(!isDossier && !isPageBlanche){
                imagePausePlay.image = UIImage(named: "ImagePauseRouge")
            }
            
            
        }
        
        else if(!oneTimer){
            oneTimer = true
            self.timer.invalidate()
            labelTimer.textColor = UIColor.darkTextColor()
            if(!isDossier && !isPageBlanche){
                imagePausePlay.image = UIImage(named: "ImageTriangle")
            }
        }
        
    }
    
    func pageBlanche(){
        imagePausePlay.image = UIImage(named: "PageBlanche")
        isPageBlanche = true
    }
    
    func dossier(){
        imagePausePlay.image = UIImage(named: "Dossier")
        isDossier = true
    }
    
    internal func incrementer(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        chrono += 1
        myDefaults.setValue(chrono, forKey: "keyChrono" + String(identifier))
        labelTimer.text = String(chrono)
        
    }
}
