//
//  ViewController.swift
//  AparatMostView
//
//  Created by nastaran on 5/20/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DisplaySwitcher


//MARK:  constants
let SITE_URL = "https://www.aparat.com//etc/api/mostviewedvideos"
private let animationDuration: TimeInterval = 0.3





class ViewController: UIViewController {

    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var VideoData = [VideoModel]()
    var nextPageUrl = ""
    var selectedVideoUrl = ""
    
    
    
    
    private lazy var listLayout = DisplaySwitchLayout(staticCellHeight: 120, nextLayoutStaticCellHeight: 280, layoutState: .list)
    
    private lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: 280, nextLayoutStaticCellHeight: 120, layoutState: .grid)
    
    private var layoutState: LayoutState = .list
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = listLayout
        
        
        
        
        getSiteData(url: SITE_URL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getSiteData(url:String) {
        Alamofire.request(url).responseJSON { response in
            // response serialization result
            let json:JSON = JSON(response.result.value!)
            
                self.parsJSON(json: json)
        }
        
    }
    
    func parsJSON(json:Any) {
        
        if let json = json as? JSON {
            let mostViewedItems = json["mostviewedvideos"].arrayValue
            nextPageUrl = json["ui"]["pagingForward"].stringValue
            
            for data in mostViewedItems {
                // print("titles: \(title["title"])")
                let title = data["title"].stringValue
                let photoUrl = data["big_poster"].stringValue
                let frame = data["frame"].stringValue
                let uniqueId = data["uid"].stringValue
                let date = data["sdate"].stringValue
                let viewCount = data["visit_cnt"].intValue
               // print(frame)
                
                VideoData.append(VideoModel(title: title, url: photoUrl, videoframe: frame, heroId: uniqueId, date: date, viewCount: viewCount))
                
            }
            
        }

        collectionView.reloadData()
  
    }
    
    //MARK: Switch Button
    @IBAction func switchLayout(_ sender: UIButton) {
        
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: gridLayout, layoutState: layoutState)
           switchButton.setTitle("List layout", for: .normal)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: listLayout, layoutState: layoutState)
            switchButton.setTitle("Grid layout", for: .normal)
        }
        transitionManager.startInteractiveTransition()

    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            if let videoVc = segue.destination as? PlayVideoVC {
                
                if let videoInfo = sender as? Dictionary<String, String> {
                print("selected video: \(selectedVideoUrl)")
                    videoVc.videoUrl = videoInfo["url"]!
                    videoVc.uId = videoInfo["uId"]!
                    videoVc.titleText = videoInfo["title"]!
                    videoVc.posterUrl = videoInfo["posterUrl"]!
                    videoVc.date = videoInfo["date"]!
                    videoVc.viewCount = videoInfo["vCount"]!
                    
                }
                
            }
            
        }
    }
    

}




//MARK: Collection Delegate
extension ViewController: UICollectionViewDelegate {
    
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        let videoUrl = VideoData[indexPath.row].videoframe
        let uniqueId = VideoData[indexPath.row].heroId
        let videoTitle = VideoData[indexPath.row].title
        let posterUrl = VideoData[indexPath.row].PhotoUrl
        let date = VideoData[indexPath.row].date
        let viewCount = VideoData[indexPath.row].viewCount
        let videoInfo = ["url":videoUrl,"uId":uniqueId,"title":videoTitle,"posterUrl":posterUrl,"date":date,"vCount":String(viewCount)]
        
       
        performSegue(withIdentifier: "showVideo", sender: videoInfo)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1  == VideoData.count {
            getSiteData(url: nextPageUrl)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
}

//MARK: Collection DataSource
extension ViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VideoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? VideoCell {
            if layoutState == .grid {
                cell.setUpGridLayout()
            } else {
                cell.setUpListLayout()
            }
            let url = URL(string: VideoData[indexPath.row].PhotoUrl)
            cell.posterImage.sd_setImage(with: url!, placeholderImage: UIImage(named: "default"), options: .highPriority, completed: nil)
            cell.configCell(model: VideoData[indexPath.row])
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
}

