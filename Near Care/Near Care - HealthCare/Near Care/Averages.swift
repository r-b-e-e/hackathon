//
//  Averages.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import Foundation

struct Averages {
    let avgRateOfMortality: String?
    let avgRateOfComplications: String?
    let avgPatientExp: String?
    let avgMedicareCoverage: String?
    
    init(jsonResponse: NSDictionary) {
        print(jsonResponse["avg_mortality"])
        self.avgRateOfMortality = jsonResponse["avg_mortality"] as? String
        self.avgRateOfComplications = jsonResponse["avg_complication"] as? String
        self.avgPatientExp = jsonResponse["avg_experience"] as? String
        self.avgMedicareCoverage = jsonResponse["avg_coverage"] as? String
    }
    
}