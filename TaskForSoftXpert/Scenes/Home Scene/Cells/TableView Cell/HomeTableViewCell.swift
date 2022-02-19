//
//  HomeTableViewCell.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/18/22.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell, ReusableView {
    
    // MARK:- OutLets
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var healthLbl: UILabel!
    
    // MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Methods
    func configure(result: RecipeResult?) {
        self.titleLbl.text = result?.title  ?? ""
        self.sourceLbl.text = "From \(result?.source  ?? "")"
        self.healthLbl.text = result?.healthLabels?.joined(separator: ",  ")  ?? ""
        if let url = URL(string: result?.image ?? "")  {
            recipeImg.kf.indicatorType = .activity
            recipeImg.kf.setImage(with: url)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
