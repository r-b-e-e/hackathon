//
//  CustomField.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit

class CustomField: UITextField {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let button = UIButton(frame: CGRectMake(0, 0, 15, 15))
        button.setImage(UIImage(named: "near_me.png"), forState: .Normal)
        self.rightView = button
        
        self.clearButtonMode = UITextFieldViewMode.Never
        self.rightViewMode = UITextFieldViewMode.Always
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
