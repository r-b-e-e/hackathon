//
//  HospitalTableCell.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 29/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit

class HospitalTableCell: UITableViewCell {

    @IBOutlet var hospitalIcon: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var absRank: UILabel!
    
    var hospitalObject: Hospital?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if hospitalObject?.type == "Acute Care - Veterans Administration" {
            hospitalIcon.image = UIImage(named: "vet.png")
        }else if hospitalObject?.type == "Acute Care Hospitals"{
            hospitalIcon.image = UIImage(named: "acute.png")
        }else if hospitalObject?.type == "Childrens" {
            hospitalIcon.image = UIImage(named: "child.png")
        }else {
            hospitalIcon.image = UIImage(named: "critical.png")
        }
        
//        print(hospitalObject?.absRanValue)
//        let value = Double(hospitalObject!.absRanValue!)! * 100
//        self.absRank.text = "\(value)%"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func opneMaps(sender: AnyObject) {
        
        
    }
    
    @IBAction func placeCall(sender: AnyObject) {
        
        if let url = NSURL(string: "tel://\(hospitalObject!.phone!)") {
            print("Calling")
            UIApplication.sharedApplication().openURL(url)
        }
    }
}
