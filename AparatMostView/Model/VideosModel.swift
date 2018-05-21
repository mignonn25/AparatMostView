//
//  VideosModel.swift
//  AparatMostView
//
//  Created by nastaran on 5/20/18.
//  Copyright © 2018 Farzad. All rights reserved.
//

import Foundation

class VideoModel {
    private var _title:String!
    var title:String{
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    private var _PhotoUrl:String!
    var PhotoUrl:String{
        if _PhotoUrl == nil {
            _PhotoUrl = ""
        }
        return _PhotoUrl
    }
    
    private var _videoframe:String!
    var videoframe:String{
        if _videoframe == nil {
            _videoframe = ""
        }
        return _videoframe
    }
    
    private var _heroId:String!
    var heroId:String{
        if _heroId == nil {
            _heroId = ""
        }
        return _heroId
    }
    
    private var _date:String!
    var date:String{
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    private var _viewCount:Int!
    var viewCount:Int{
        if _viewCount == nil {
            _viewCount = 0
        }
        return _viewCount
    }
    
    
    init(title: String,url:String,videoframe:String,heroId:String,date:String,viewCount:Int) {
        self._title = title
        self._PhotoUrl = url
        self._videoframe = videoframe
        self._heroId = heroId
        self._date = date
        self._viewCount = viewCount
    }
}
