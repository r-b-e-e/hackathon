//
//  Hospital.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import Foundation
struct Hospital {
    
    let name: String?
    let address: String?
    let city: String?
    let state: String?
    let zipcode: String?
//    let county: String?
    let phone: String?
    let type: String?
    let ownership: String?
    let emergencyServices: String?
    let rateOfMortality: String?
    let rateOfComplication: String?
    let patientExperience: String?
    let mdeicareCoverage: String?
//    //let rankValue: String?
    let absRanValue: String?
//    let avgRateOfMortality: String?
//    let avgRateOfComplications: String?
//    let avgPatientExp: String?
//    let avgMedicareCoverage: String?
    
    
    init(jsonResponse: NSDictionary) {
        self.name = jsonResponse["hospital_name"] as? String
        self.address = jsonResponse["address"] as? String
        self.city = jsonResponse["city"] as? String
        self.state = jsonResponse["state"] as? String
        self.zipcode = jsonResponse["zip_code"] as? String
        self.phone = jsonResponse["phone_number"] as? String
        self.type = jsonResponse["hospital_type"] as? String
        self.ownership = jsonResponse["hospital_ownership"] as? String
        self.emergencyServices = jsonResponse["emergency_services"] as? String
        self.rateOfMortality = jsonResponse["rate_of_mortality"] as? String
        self.rateOfComplication = jsonResponse["rate_of_complication"] as? String
        self.patientExperience = jsonResponse["patient_experience"] as? String
        self.mdeicareCoverage = jsonResponse["medicare_coverage"] as? String
        self.absRanValue = jsonResponse["abs_rank_value"] as? String
    }
    
}