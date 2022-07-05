//
//  HomeViewController.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    var passwords: Passwords = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var filteredPassowrds: Passwords = []
    
    let searchController = UISearchController(searchResultsController: nil)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        
        self.presenter?.getPasswords()
        filteredPassowrds = passwords
    }
}

// MARK: - Setup Layout
extension HomeViewController {
    
    fileprivate func makeLayout() {
        self.view.backgroundColor = .viewBackground
        self.showLoadingDialog()
        
        setupNavigation()
        setupCollectionView()
        setupConstraints()
    }
    
    fileprivate func setupNavigation() {
        self.title = "Passwords"
        
        let profileButton = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(profileButtonTapped))
        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(createButtonTapped))

        self.navigationItem.leftBarButtonItem = profileButton
        self.navigationItem.rightBarButtonItem = createButton
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PasswordCell.self)
        collectionView.backgroundColor = .viewBackground
        collectionView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(collectionView)
    }
    
    fileprivate func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func profileButtonTapped(sender: UIButton) {
        presenter?.showProfile()
    }
    
    @objc func createButtonTapped(sender: UIButton) {
        presenter?.showNewPassword()
    }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func setPasswords(passwords: Passwords) {
        self.passwords = passwords
        self.hideLoadingDialog()
    }
    
    func errorService(message: String) {
        self.hideLoadingDialog()
        self.showActivityPopup(title: message)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let seeAction = UIAction(title: "See", image: UIImage(systemName: "eyes")) { _ in
                print("See Action")
            }
                
            let pinAction = UIAction(title: "Pin", image: UIImage(systemName: "pin")) { _ in
                print("Pin Action")
            }
                
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                print("Delete Action")
            }
                
            return UIMenu(title: "", children: [seeAction, pinAction, deleteAction])
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPassowrds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let passwordCell: PasswordCell = collectionView.dequeueReusableCell(for: indexPath)
        passwordCell.setCell(password: self.passwords[indexPath.row])
        return passwordCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    private func calculateCellSize(at indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40.0, height: 68.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calculateCellSize(at: indexPath)
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let currentFilter = searchController.searchBar.text {
            if currentFilter != "" {
                var tempPasswords: Passwords = []
                
                for password in self.passwords {
                    if password.serviceName.contains(currentFilter) {
                        tempPasswords.append(password)
                    }
                }
                
                self.filteredPassowrds = tempPasswords
            } else {
                self.filteredPassowrds = self.passwords
            }
        }
        
        self.collectionView.reloadData()
    }
}
