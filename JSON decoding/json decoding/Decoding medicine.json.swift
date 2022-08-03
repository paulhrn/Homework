//
//  medicine.json decoding.swift
//  json decoding
//
//  Created by p h on 02.08.2022.
//

import Foundation
import UIKit

struct Medicine: Decodable {
    var medications: [Medications]
    var labs: [Labs]
    var imaging: [Imaging]
}

struct Medications: Decodable {
    var aceInhibitors,
        antianginal,
        anticoagulants,
        betaBlocker,
        diuretic,
        mineral: [MedicationDescription]
   
    enum CodingKeys: String, CodingKey {
        case  antianginal, anticoagulants, diuretic, mineral
        case aceInhibitors = "ace_inhibitors"
        case betaBlocker = "beta_blocker"
    }
}

struct MedicationDescription: Decodable {
    var name: String
    var strength: String
    var dose: String
    var route: String
    var sig: String
    var pillCount: Int?
    var refills: String
    
    enum CodingKeys: String, CodingKey {
        case name, strength, dose, route, sig, refills
        case pillCount = "pill_count"
    }
}

struct Labs: Decodable {
    var name: String
    var time: String
    var location: String
}

struct Imaging: Decodable {
    var name: String
    var time: String
    var location: String
}
