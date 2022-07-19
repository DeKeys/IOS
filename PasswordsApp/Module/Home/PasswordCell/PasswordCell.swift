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

    let serviceImage = ServiceView()
    let serviceLabel = UILabel()
    let loginLabel = UILabel()
    let interactionImage = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.makeLayout()
    }
    
    func setCell(password: Password) {
        self.password = password
        
        serviceImage.serviceName = password.serviceName
        serviceLabel.text = password.serviceName
        loginLabel.text = password.login
        interactionImage.image = UIImage(systemName: password.pinned ? "pin.circle" : "key.viewfinder")
    }

    fileprivate func makeLayout() {
        self.layer.cornerRadius = 12
    
        // style labels
        serviceLabel.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .medium)
        serviceLabel.textColor = .white
        
        loginLabel.font = UIFont.systemFont(ofSize: CGFloat(16), weight: .medium)
        loginLabel.textColor = .white
        
        // style image
        interactionImage.tintColor = .white
        
        // cretae stack for labes
        let labelStackView = UIStackView(arrangedSubviews: [serviceLabel, loginLabel])
        labelStackView.distribution = .fillEqually
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        
        // place all elemetns on the view
        self.addSubview(serviceImage)
        self.addSubview(labelStackView)
        self.addSubview(interactionImage)
        
        // add some constraints
        serviceImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(self.frame.height - 8)
            make.left.equalTo(10)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(serviceImage.snp.right).offset(10)
        }
        
        interactionImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.height.width.equalTo(28)
            make.right.equalTo(-10)
        }
    }
}
