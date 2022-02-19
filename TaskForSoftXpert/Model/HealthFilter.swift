//
//  HealthFilter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

enum HealthFilter: String {
    static let items: [HealthFilter] = [.all, .lowSugar, .keto, .vegan]
    
    case all = "All"
    case lowSugar = "low-sugar"
    case keto = "keto-friendly"
    case vegan = "vegan"
    
}
