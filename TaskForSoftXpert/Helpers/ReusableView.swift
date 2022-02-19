//
//  ReusableView.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/18/22.
//

import Foundation

protocol ReusableView: AnyObject {}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
