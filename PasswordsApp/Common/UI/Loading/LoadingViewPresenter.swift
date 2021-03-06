//
//  LoadingViewPresenter.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit
import SnapKit

class LoadingViewPresenter {
    
    static let shared = LoadingViewPresenter()
    
    func hide() {
        for window in UIApplication.shared.windows {
            for item in window.subviews where item is LoadingView {
                item.removeFromSuperview()
            }
        }
    }
    
    func show() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        let loadingView = LoadingView(frame: UIScreen.main.bounds)
        keyWindow.addSubview(loadingView)
        
        loadingView.alpha = 0
        loadingView.isHidden = true
        loadingView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(keyWindow)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            loadingView.alpha = 1.0
            loadingView.isHidden = false
        })
    }
}
