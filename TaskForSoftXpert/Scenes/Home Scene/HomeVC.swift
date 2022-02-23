//
//  HomeVC.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/18/22.
//

import UIKit
import DropDown

class HomeVC: UIViewController {
    
    // MARK:- Properties
    var presenter: ViewToPresenterHomeProtocol?
    var selectedCellIndexpth = IndexPath(item: 0, section: 0)
    let dropDown = DropDown()
    let footer = IndicatorFooter()
    
    // MARK:- OutLets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionview()
        configureTableView()
        configureSearchBar()
        addDropDown()
        addFooterIndicator()
        self.presenter?.viewDidLoad()
    }
}

//MARK:- Methods
extension HomeVC {
    private func configureTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        registerTableViewCells()
    }
    
    private func configureCollectionview() {
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.registerCollectionViewCells()
        self.setCollectionViewInsets()
    }
    
    private func registerTableViewCells() {
        homeTableView.register(UINib(nibName: HomeTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
    }
    
    private func registerCollectionViewCells() {
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
    }
    
    private func setCollectionViewInsets() {
        self.filterCollectionView.contentInset = UIEdgeInsets.zero
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.frame = self.view.bounds
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        self.title = "Recipes Search"
    }
    
    private func setCellSelection(status: Bool, at indexPath: IndexPath) {
        if let cell = filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
            cell.isSelected = status
        }
    }
    
    private func addDropDown() {
        dropDown.anchorView = searchBar
        dropDown.bottomOffset = CGPoint(x: 0, y: self.navigationController?.navigationBar.bounds.height ?? 0)
        dropDown.direction = .bottom
        dropDown.dismissMode = .automatic
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.searchBar.text = item
        }
    }
    
    private func addFooterIndicator() {
        let footer = IndicatorFooter()
        homeTableView.tableFooterView = footer
    }
    
    private func resetTableView() {
        homeTableView.isHidden = false
        homeTableView.setContentOffset(CGPoint.zero, animated: false)
        homeTableView.reloadData()
        homeTableView.layoutIfNeeded()
        homeTableView.setContentOffset(CGPoint.zero, animated: false)
    }
}

//MARK:- UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        presenter?.didStartTyping()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dropDown.show()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let query = searchBar.text ?? ""
        presenter?.search(for: query, at: selectedCellIndexpth.row)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}

//MARK:- CollectionView
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfCollectionViewItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as! FilterCollectionViewCell
        cell.titleLabel.text = self.presenter?.filterItem(at: indexPath.row)
        cell.isSelected = indexPath.row == 0 ? true : false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width / 3, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchBar.resignFirstResponder()
        guard indexPath != selectedCellIndexpth else {return}
        setCellSelection(status: false, at: selectedCellIndexpth)
        selectedCellIndexpth = indexPath
        self.presenter?.didSelectFilterItemAt(index: indexPath.row)
    }
}

//MARK:- TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as! HomeTableViewCell
        cell.configure(result: presenter?.resultCell(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectRowAt(index: indexPath.row)
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeTableView.frame.height / 3
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (homeTableView.contentOffset.y + 1) >= (homeTableView.contentSize.height - homeTableView.frame.size.height) {
            
            self.presenter?.didDisplayLastRow()
        }
    }
}

//MARK:- PresenterToViewHomeProtocol
extension HomeVC: PresenterToViewHomeProtocol {
    
    func showDropDown(with data: [String]) {
        dropDown.dataSource = data
        dropDown.show()
    }
    
    func hideDropDown() {
        dropDown.hide()
    }
    
    func loadCollectionView() {
        self.filterCollectionView.reloadData()
    }
    
    func resetResultsView() {
        resetTableView()
    }
    
    func updateResultsView() {
        homeTableView.isHidden = false
        homeTableView.reloadData()
    }
    
    
    func hideTableView() {
        homeTableView.isHidden = true
    }
    
    func showAlertMessage(error: String) {
        self.showAlert(with: error)
    }
    
    func showHUD() {
        self.showIndicator()
    }
    
    func hideHUD() {
        self.hideIndicator()
    }
    
    func showFooterIndicator() {
        homeTableView.tableFooterView?.bounds.size.height = 50
    }
    
    func hideFooterIndicator() {
        homeTableView.tableFooterView?.bounds.size.height = 0
    }
}

