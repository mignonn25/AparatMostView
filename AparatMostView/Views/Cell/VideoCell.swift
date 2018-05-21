//
//  VideoCell.swift
//  AparatMostView
//
//  Created by nastaran on 5/20/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import UIKit
//import DisplaySwitcher


class VideoCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
   @IBOutlet weak var listTitleLabel: UILabel!
   
    
    @IBOutlet weak var titleListLeadingConstraint: NSLayoutConstraint! 
    
    @IBOutlet weak var listTitleTrailingCons: NSLayoutConstraint!
    @IBOutlet weak var posterWidthConst: NSLayoutConstraint!
    
    
    
    func configCell(model: VideoModel) {
        titleLabel.text = model.title
        listTitleLabel.text = model.title
        
      //  let url = URL(string: model.PhotoUrl)
       // posterImage.load(url: url!)
    }
    
    func setUpListLayout() {
        listTitleLabel.alpha = 1
        listTitleTrailingCons.constant = 10
        titleListLeadingConstraint.constant = 10
        posterWidthConst.constant = 120
        
    }
    
    func setUpGridLayout() {
        listTitleLabel.alpha = 0
        listTitleTrailingCons.constant = 0
        titleListLeadingConstraint.constant = 0
        posterWidthConst.constant = 200
        
    }
    
    
}
