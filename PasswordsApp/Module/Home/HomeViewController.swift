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
    var filteredPasswords: Passwords = []
    
    let searchController = UISearchController(searchResultsController: nil)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let contextMenu = ContextMenu.shared
    let passwordVC = PasswordViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        
        self.presenter?.getPasswords()
        filteredPasswords = passwords
        
        passwordVC.presenter = self.presenter
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
        profileButton.image = UIImage(systemName: "gearshape")
        profileButton.tintColor = .textColor
        
        let createButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(createButtonTapped))
        createButton.image = UIImage(systemName: "plus")
        createButton.tintColor = .textColor

        self.navigationItem.leftBarButtonItem = profileButton
        self.navigationItem.rightBarButtonItem = createButton
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.tintColor = .textColor
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
    
    func closePasswordVC() {
        self.presenter?.getPasswords()
        filteredPasswords = passwords
        self.passwordVC.dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPassword = self.passwords[indexPath.row]
        passwordVC.configureUI(with: currentPassword)
        
        contextMenu.show(
            sourceViewController: self,
            viewController: passwordVC,
            delegate: self
        )
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPasswords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let passwordCell: PasswordCell = collectionView.dequeueReusableCell(for: indexPath)
        passwordCell.setCell(password: self.filteredPasswords[indexPath.row])
        return passwordCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    private func calculateCellSize(at indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20.0, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calculateCellSize(at: indexPath)
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
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
                    if password.serviceName.hasPrefix(currentFilter) {
                        tempPasswords.append(password)
                    }
                }
                
                self.filteredPasswords = tempPasswords
            } else {
                self.filteredPasswords = self.passwords
            }
        }
        
        self.collectionView.reloadData()
    }
}

extension HomeViewController: ContextMenuDelegate {
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool) {
        print("will dismiss")
    }

    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool) {
        print("did dismiss")
    }
}
