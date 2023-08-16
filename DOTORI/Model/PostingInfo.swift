//
//  PostingInfo.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation

class PostingInfo : UserInfo {
    var category : String = ""
    var content : String =  ""
    var createTime : Date = Date()
    var updateTime : Date = Date()
    var contentImage : String = ""
    var bookmark : Bool = false
    var bookmarkCount : Int = 0
    var reply : [ReplyInfo] = []
}
