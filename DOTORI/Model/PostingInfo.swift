//
//  PostingInfo.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation
import UIKit

class PostingInfo {
    var category : String = ""
    var content : String =  ""
    var createTime : Date = Date()
    var updateTime : Date = Date()
    var contentImage : UIImage?
    var bookmark : Bool = false
    var bookmarkCount : Int = 0
    var reply : [ReplyInfo] = []
    var user : UserInfo = UserInfo()
}
