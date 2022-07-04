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
    let interactButton = UIButton()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.makeLayout()
    }
    
    func setCell(password: Password) {
        self.password = password
        
        serviceImage.centeredLetter = String(password.serviceName.first!)
        serviceLabel.text = password.serviceName
        loginLabel.text = password.login
    }

    fileprivate func makeLayout() {
        self.layer.cornerRadius = 12
    
        // style labels
        let systemFont = UIFont.systemFont(ofSize: CGFloat(18), weight: .medium)
        if let descriptor = UIFont.systemFont(ofSize: CGFloat(18), weight: .medium).fontDescriptor.withDesign(.rounded) {
            let roundedFont = UIFont(descriptor: descriptor, size: CGFloat(18))
            serviceLabel.font = roundedFont
            loginLabel.font = roundedFont
        } else {
            serviceLabel.font = systemFont
            loginLabel.font = systemFont
        }
        
        // style button
        interactButton.setTitle("See", for: .normal)
        interactButton.setTitleColor(.black, for: .normal)
        interactButton.layer.borderWidth = 0.8
        interactButton.layer.borderColor = UIColor.black.cgColor
        interactButton.layer.cornerRadius = 12
        
        // cretae stack for labes
        let labelStackView = UIStackView(arrangedSubviews: [serviceLabel, loginLabel])
        labelStackView.distribution = .fillEqually
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        // place all elemetns on the view
        self.addSubview(serviceImage)
        self.addSubview(labelStackView)
        self.addSubview(interactButton)
        
        // add some constraints
        serviceImage.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.height.equalTo(self.frame.height - 2)
            make.left.equalTo(10)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(serviceImage.snp.right).offset(20)
        }
        
        interactButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.width.equalTo(60)
            make.right.equalTo(-10)
        }
    }
}
