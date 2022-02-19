//
//  HomeVC.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/18/22.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK:- OutLets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK:- Methods
    private func setupView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        register()
    }
    
    private func register() {
        homeTableView.register(UINib(nibName: HomeTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        filterCollectionView.register(UINib(nibName: FilterCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
    }
    
}

// MARK:- TableViewDelegate, TableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as! HomeTableViewCell
        return cell
    }
    
}

// MARK:- CollectionViewDelegate, CollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as! FilterCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize/3, height: collectionViewSize)
    }
    
}
