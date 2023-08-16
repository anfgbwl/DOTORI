//
//  ReplyInfo.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation
import UIKit

class ReplyInfo {
    var user : UserInfo
    var content : String =  ""
    var createTime : Date = Date()
    var updateTime : Date = Date()
    
    init(user : UserInfo, content: String, createTime: Date, updateTime: Date) {
        self.user = user
        self.content = content
        self.createTime = createTime
        self.updateTime = updateTime
    }
}

