//
//  CompletedTasksViewController.swift
//  To-Do-List
//
//  Created by Liam Leahy on 10/11/15.
//  Copyright © 2015 Liam Leahy. All rights reserved.
//

import UIKit

class CompletedTasksViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counter)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}
