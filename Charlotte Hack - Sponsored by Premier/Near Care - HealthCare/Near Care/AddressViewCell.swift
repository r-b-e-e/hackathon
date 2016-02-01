//
//  AddressViewCell.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit

class AddressViewCell: UITableViewCell {

    
    @IBOutlet var address: UITextView!
    @IBOutlet var phone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
