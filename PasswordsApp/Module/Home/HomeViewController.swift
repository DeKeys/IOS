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
            filteredPasswords = passwords
            self.reloadData()
        }
    }
    var filteredPasswords: Passwords = []
    
    let searchController = UISearchController(searchResultsController: nil)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let contextMenu = ContextMenu.shared
    let passwordVC = PasswordViewController()
    let footerView = AddNewPasswordView()
    
    private let notificationCenter = NotificationCenter.default
    private var observationToken: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        
        passwordVC.presenter = presenter
        
        observationToken = notificationCenter.addObserver(forName: NSNotification.Name("new password"), object: nil, queue: nil) { _ in
            self.presenter?.getPasswords()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        presenter?.getPasswords()
    }
    
    private func reloadData() {
        UIView.transition(with: collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: { () -> Void in
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(observationToken!)
    }
}

// MARK: - Setup Layout
extension HomeViewController {
    
    fileprivate func makeLayout() {
        self.view.backgroundColor = .background
        self.showLoadingDialog()
        
        setupNavigation()
        setupCollectionView()
        addFooterView()
        setupConstraints()
    }
    
    fileprivate func setupNavigation() {
        self.title = "Passwords"
        
        let profileButton = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(profileButtonTapped))
        profileButton.image = UIImage(systemName: "gearshape")
        profileButton.tintColor = .white
        
        let createButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(createButtonTapped))
        createButton.image = UIImage(systemName: "plus")
        createButton.tintColor = .white

        self.navigationItem.leftBarButtonItem = profileButton
        self.navigationItem.rightBarButtonItem = createButton
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PasswordCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(collectionView)
    }
    
    fileprivate func addFooterView() {
        self.view.addSubview(footerView)
    }
    
    fileprivate func setupConstraints() {
        footerView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
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
        reloadCollectionView()
        self.passwordVC.dismiss(animated: true)
    }
    
    func reloadCollectionView() {
        self.presenter?.getPasswords()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40.0, height: 80)
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
                    if password.serviceName.hasPrefix(currentFilter) {
                        tempPasswords.append(password)
                    }
                }
                
                self.filteredPasswords = tempPasswords
            } else {
                self.filteredPasswords = self.passwords
            }
        }
        
        self.reloadData()
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
