//
//  AddNewPasswordView.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/20/22.
//

import UIKit
import SnapKit

class AddNewPasswordView: UIView {
    
    let serviceImageHolder = UIImageView()
    let serviceLabelHolder = UIImageView()
    let loginLabelHolder = UIImageView()
    
    let labelStackView = UIStackView()
    
    let borderLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayer.lineWidth = 4
        borderLayer.strokeColor = .cellBackground
        borderLayer.lineDashPattern = [8, 10]
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 12, height: 12)).cgPath

        self.layer.addSublayer(borderLayer)
    }

    private func setupView() {
        
        self.backgroundColor = .cellBackground
            
        // style cell
        self.layer.cornerRadius = 12
        self.layer.backgroundColor = UIColor.cellBackground.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        // set service image
        serviceImageHolder.backgroundColor = .green
        serviceLabelHolder.backgroundColor = .red
        loginLabelHolder.backgroundColor = .blue
        
        // cretae stack for labes
        labelStackView.addArrangedSubview(serviceLabelHolder)
        labelStackView.addArrangedSubview(loginLabelHolder)
        labelStackView.distribution = .fillProportionally
        labelStackView.axis = .vertical
        labelStackView.spacing = 0

        // place all elemetns on the view
        self.addSubview(serviceImageHolder)
        self.addSubview(labelStackView)
    }
    
    private func setupConstraints() {
        serviceImageHolder.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(12)
        }

        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(serviceImageHolder.snp.right).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(40)
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
