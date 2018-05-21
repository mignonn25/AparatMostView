//
//  PlayVideoVC.swift
//  AparatMostView
//
//  Created by nastaran on 5/21/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import UIKit
import WebKit
import Hero

class PlayVideoVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var titleText = ""
    var videoUrl = ""
    var uId = ""
    var posterUrl = ""
    var viewCount = ""
    var date = ""
    
    var panGR: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        poster.sd_setImage(with: URL(string: posterUrl)!, placeholderImage: UIImage(named: "default"), options: .highPriority, completed: nil)
        
        titleLabel.text = titleText
        dateLabel.text = date
        viewLabel.text = viewCount
        
        border.hero.id = uId + "border"
        titleLabel.hero.id = uId + "listTitle"
        poster.hero.id = uId + "poster"
        
        panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panGR)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("videourl : \(videoUrl)")
        let url = URL(string: videoUrl)
        if let url = url {
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
        
        

    }
    
    @objc func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        // calculate the progress based on how far the user moved
        let translation = panGR.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch panGR.state {
        case .began:
            // begin the transition as normal
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress)
            
            // update views' position (limited to only vertical scroll)
//            Hero.shared.apply(modifiers: [.position(CGPoint(x:imageView.center.x, y:translation.y + imageView.center.y))], to: imageView)
//            Hero.shared.apply(modifiers: [.position(CGPoint(x:nameLabel.center.x, y:translation.y + nameLabel.center.y))], to: nameLabel)
//            Hero.shared.apply(modifiers: [.position(CGPoint(x:descriptionLabel.center.x, y:translation.y + descriptionLabel.center.y))], to: descriptionLabel)
        default:
            // end or cancel the transition based on the progress and user's touch velocity
            if progress + panGR.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
