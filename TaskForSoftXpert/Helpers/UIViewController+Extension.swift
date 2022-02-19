//
//  UIViewController+Extension.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit
import PKHUD

extension UIViewController {
    func showIndicator() {
        HUD.show(.progress)
    }
    
    func hideIndicator() {
        HUD.hide()
    }
    
    func showAlert(with text: String?) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
