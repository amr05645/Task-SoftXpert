//
//  HomeTableViewCell.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/18/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell, ReusableView {
    
    // MARK:- OutLets
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var healthLbl: UILabel!
    
    // MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
