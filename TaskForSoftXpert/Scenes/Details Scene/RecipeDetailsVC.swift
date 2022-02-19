//
//  RecipeDetailsVC.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit
import Kingfisher
import SafariServices

class RecipeDetailsVC: UIViewController, SFSafariViewControllerDelegate {
    
    // MARK:- Properties
    var presenter: ViewToPresenterDetailsProtocol?
    
    // MARK:- OutLets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.isEditable = false
        self.title = "Recipes Details"
        self.presenter?.viewDidLoad()
        addShareBtn()
    }
    
    // MARK:- Actions
    @IBAction func recipeWebsiteTapped(_ sender: Any) {
        presenter?.didTapWebite()
    }
}

//MARK:- Methods
extension RecipeDetailsVC {
    private func addShareBtn() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "share"), for: UIControl.State.normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(shareTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func shareTapped() {
        presenter?.didTapShare()
    }
}

//MARK:- PresenterToViewDetailsProtocol
extension RecipeDetailsVC: PresenterToViewDetailsProtocol {
    
    func updateDetailsView(title: String, imageUrl: String, ingredients: String) {
        self.titleLbl.text = title
        self.ingredientsTextView.text = ingredients
        if let url = URL(string: imageUrl)  {
            recipeImageView.kf.indicatorType = .activity
            recipeImageView.kf.setImage(with: url)
        }
    }
}
