//
//  UserInfo.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import Foundation
import UIKit

class UserInfo {
    var profileImage : UIImage?
    var name : String = ""
    var nickname : String =  ""
    var githubUrl : String = ""
    var blogUrl : String = ""
    var userIntro : String = ""
    
    init(profileImage: UIImage? = nil, name: String, nickname: String, githubUrl: String, blogUrl: String, userIntro: String) {
        self.profileImage = profileImage
        self.name = name
        self.nickname = nickname
        self.githubUrl = githubUrl
        self.blogUrl = blogUrl
        self.userIntro = userIntro
    }
}
