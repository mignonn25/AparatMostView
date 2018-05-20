//
//  Extentions.swift
//  AparatMostView
//
//  Created by nastaran on 5/20/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import Foundation
import UIKit


//MARK: Load Image async
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
