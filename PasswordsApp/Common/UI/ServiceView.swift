//
//  ServiceImageView.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/4/22.
//

import UIKit
import SnapKit

class ServiceView: UIView {
    
    var serviceName: String = "" {
        didSet {
            if let firstSymbol = serviceName.first {
                self.centeredLabel.text = String(firstSymbol)
            }
        }
    }
    
    lazy var centeredLabel: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        headerTitle.text = "Custom View"
        headerTitle.textAlignment = .center
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.generateColorFor(text: serviceName)
        self.layer.cornerRadius = self.layer.bounds.width / 2
        self.layer.masksToBounds = true
    }

    private func setupView() {
        
        // style letter
        centeredLabel.font = UIFont.systemFont(ofSize: CGFloat(24), weight: .regular)
        centeredLabel.numberOfLines = 0
        centeredLabel.textColor = .white
        
        // add on the view
        self.addSubview(centeredLabel)
        
        // append contrstraints
        centeredLabel.snp.makeConstraints { [weak self] make in
            make.centerX.centerY.equalTo(self!)
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
