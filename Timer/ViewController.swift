//
//  ViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 01/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var tableView: UITableView!

    var data = ["All Tasks" ,"Single Task"]
    var dataTimer = ["0","0"]
  
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return (data.count)
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        print(indexPath.row)
        cell.labelTimer.text = dataTimer[indexPath.row]
        cell.label.text = data[indexPath.row]
        
        return cell
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        currentCell.activerTimer()
    }

}

