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
//        interactionImage.image = UIImage(systemName: "key.viewfinder")
        self.layer.borderColor = password.pinned ? .pinBorder : .cellBackground
    }

    fileprivate func makeLayout() {
        
        // style cell
        self.layer.cornerRadius = 12
        self.layer.backgroundColor = .cellBackground
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.borderWidth = 4.0

        // style labels
        serviceLabel.font = UIFont(font: FontFamily.Poppins.bold, size: 22)
        serviceLabel.textColor = .white
        
        loginLabel.font = UIFont(font: FontFamily.Poppins.regular, size: 16)
        loginLabel.textColor = .white
        
        // style image
        interactionImage.tintColor = .white
        
        // cretae stack for labes
        let labelStackView = UIStackView(arrangedSubviews: [serviceLabel, loginLabel])
        labelStackView.distribution = .fillProportionally
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        
        // place all elemetns on the view
        self.addSubview(serviceImage)
        self.addSubview(labelStackView)
        self.addSubview(interactionImage)
        
        // add some constraints
        serviceImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(self.frame.height)
            make.left.equalTo(14)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(serviceImage.snp.right).offset(10)
        }
        
        interactionImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.height.width.equalTo(28)
            make.right.equalTo(-14)
        }
    }
}
