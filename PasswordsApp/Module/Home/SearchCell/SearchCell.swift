//
//  SearchCell.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/4/22.
//

import UIKit
import SnapKit

class SearchCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    let serviceLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.makeLayout()
        serviceLabel.text = "kjnknnknjkn"
    }

    fileprivate func makeLayout() {
        self.layer.cornerRadius = 12
    
        // style labels
        let systemFont = UIFont.systemFont(ofSize: CGFloat(18), weight: .medium)
        if let descriptor = UIFont.systemFont(ofSize: CGFloat(18), weight: .medium).fontDescriptor.withDesign(.rounded) {
            let roundedFont = UIFont(descriptor: descriptor, size: CGFloat(18))
            serviceLabel.font = roundedFont
        } else {
            serviceLabel.font = systemFont
        }

        self.addSubview(serviceLabel)
        
        // add some constraints
        serviceLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self)
        }
    }
}
