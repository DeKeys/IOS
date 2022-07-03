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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
    }
}

// MARK: - Setup Layout
extension HomeViewController {
    
    fileprivate func makeLayout() {
        self.createComponents()
        self.showLoadingDialog()
        
        self.presenter?.getPasswords()
    }
    
    fileprivate func createComponents() {
        
        // set backround
        self.view.backgroundColor = .viewBackground

        // setup natigation bar
        self.title = "Passwords"
        
        
        let profileButton = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(profileButtonTapped))
        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(createButtonTapped))

        self.navigationItem.leftBarButtonItem = profileButton
        self.navigationItem.rightBarButtonItem = createButton
        
        // setup collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PasswordCell.self)
        collectionView.backgroundColor = .viewBackground
        collectionView.showsVerticalScrollIndicator = false
        
        // add components and constraints
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: -
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PasswordCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setCell(password: self.passwords[indexPath.row])
        return cell
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
