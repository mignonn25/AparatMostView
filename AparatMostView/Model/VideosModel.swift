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
    
    
    init(title: String,url:String) {
        self._title = title
        self._PhotoUrl = url
    }
}
