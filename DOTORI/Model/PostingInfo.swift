//
//  PostingInfo.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation
import UIKit

class PostingInfo  {
    var user : UserInfo
    var category : String = ""
    var content : String =  ""
    var createTime : Date = Date()
    var updateTime : Date = Date()
    var contentImage : UIImage?
    var bookmark : Bool = false
    var bookmarkCount : Int = 0
    var reply : [ReplyInfo] = []
    var tilUrl : String = ""
    
    init(user : UserInfo, category: String, content: String, createTime: Date, updateTime: Date, contentImage: UIImage? = nil, bookmark: Bool, bookmarkCount: Int, reply: [ReplyInfo], tilUrl: String) {
        self.user = user
        self.category = category
        self.content = content
        self.createTime = createTime
        self.updateTime = updateTime
        self.contentImage = contentImage
        self.bookmark = bookmark
        self.bookmarkCount = bookmarkCount
        self.reply = reply
        self.tilUrl = tilUrl
    }
}
