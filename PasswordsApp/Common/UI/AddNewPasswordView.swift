//
//  AddNewPasswordView.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/20/22.
//

import UIKit
import SnapKit

class AddNewPasswordView: UIView {
    
    let plusImage = UIImageView()
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
        
        // setup plus image
        plusImage.image = UIImage(systemName: "plus")
        plusImage.tintColor = .cellBackground
        
        // place all elemetns on the view
        self.addSubview(plusImage)
    }
    
    private func setupConstraints() {
        plusImage.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(28)
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
