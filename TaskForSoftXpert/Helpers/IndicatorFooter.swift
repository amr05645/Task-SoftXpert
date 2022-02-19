//
//  IndicatorFooter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit

class IndicatorFooter: UIView {
    
    let loadingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addLabel() {
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadingLabel)
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .black
        loadingLabel.font = loadingLabel.font.withSize(20)
        
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

