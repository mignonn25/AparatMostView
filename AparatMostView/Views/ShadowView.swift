//
//  ShadowView.swift
//  AparatMostView
//
//  Created by nastaran on 5/21/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import UIKit
let SHADOW_GRAY: CGFloat = 120.0 / 255.0

class ShadowView: UIView {
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
    
    
            layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 5.0
            layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
   // layer.cornerRadius = self.frame.height / 6
   }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
