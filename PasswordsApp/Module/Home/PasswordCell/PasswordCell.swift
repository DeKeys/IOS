//
//  PasswordCell.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit
import SnapKit

class PasswordCell: UICollectionViewCell, ReusableView, NibLoadableView {

    var password: Password!
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeLayout()
    }
    
    func setCell(password: Password) {
        self.password = password
        
        titleLabel.text = password.serviceName
        bodyLabel.text = password.login
    }
    
    fileprivate func makeLayout() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.red

        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.textColor = backgroundColor!.isDarkColor ? .white : .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        bodyLabel.font = .systemFont(ofSize: 13)
        bodyLabel.textColor = backgroundColor!.isDarkColor ? .white : .black
        bodyLabel.numberOfLines = 0
        bodyLabel.lineBreakMode = .byWordWrapping
        
        // MARK: - StackView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.edges.equalToSuperview().inset(10)
        }
    }
}
