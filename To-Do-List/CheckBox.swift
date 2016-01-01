//
//  CheckBox.swift
//  To-Do-List
//
//  Created by Liam Leahy on 10/11/15.
//  Copyright © 2015 Liam Leahy. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedBox = UIImage(named: "checked_checkbox")
    let uncheckedBox = UIImage(named: "unchecked_checkbox")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedBox, forState: .Normal)
            } else {
                self.setImage(uncheckedBox, forState: .Normal)
            }
        }
    }
    
    var index: Int?
    
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
