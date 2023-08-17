//
//  Dummy.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import Foundation
import UIKit

var user1 = UserInfo(profileImage :UIImage(named: "defaultProfileImage"), name: "김서온", nickname: "김서오니", githubUrl: "https://github.com/anfgbwl", blogUrl: "https://ahrzosel.tistory.com/", userIntro: "끝까지 살아남을꺼야…")
var user2 = UserInfo(profileImage :UIImage(systemName: "lasso"), name: "이찬호", nickname: "lcho3878", githubUrl: "https://github.com/lcho3878/", blogUrl: "https://velog.io/@leech3878", userIntro: "열심히하자")
var user3 = UserInfo(profileImage :UIImage(systemName: "bookmark"), name: "이대현", nickname: "hidaehyun", githubUrl: "https://github.com/hidaehyunlee", blogUrl: "https://velog.io/@hidaehyunlee", userIntro: "노에어컨.. 노코딩.. 🌬️")
var user4 = UserInfo(profileImage :UIImage(systemName: "bookmark.fill"), name: "박유경", nickname: "hiyukyung", githubUrl: "https://github.com/ohAkse", blogUrl: "https://velog.io/@segassdc", userIntro: "화이팅")
var user5 = UserInfo(profileImage :UIImage(named: "image1"),name: "박지근", nickname: "지끈지끈", githubUrl: "https://github.com/Kyletube", blogUrl: "https://kylestory.tistory.com/", userIntro: "이거…왜 돌아가지?")

var posting1 = PostingInfo(user: user1, category: "잡담", content: "아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요", createTime: Date(), updateTime: Date(),contentImage: UIImage(named: "defaultProfileImage"),bookmark: false, bookmarkCount: 0, reply: [reply1,reply2,reply3], tilUrl: "")
var posting2 = PostingInfo(user: user2, category: "잡담", content: "타닥타닥", createTime: Date(), updateTime: Date(), contentImage: UIImage(systemName: "bookmark"),bookmark: false, bookmarkCount: 0, reply: [reply1,reply4,reply2,reply3], tilUrl: "")
var posting3 = PostingInfo(user: user3, category: "질문", content: "저녁 뭐먹을까요?", createTime: Date(), updateTime: Date(),contentImage: UIImage(named: "image1"), bookmark: false, bookmarkCount: 0, reply: [reply3,reply2,reply4,reply2], tilUrl: "")
var posting4 = PostingInfo(user: user3, category: "고양이방", content: "저녁 야옹?", createTime: Date(), updateTime: Date(),contentImage: UIImage(named: "bookmark.fill"), bookmark: false, bookmarkCount: 0, reply: [reply3,reply2,reply4,reply2], tilUrl: "")
var posting5 = PostingInfo(user: user5, category: "TIL", content: "UserDefault", createTime: Date(), updateTime: Date(),contentImage: UIImage(systemName: "lasso"), bookmark: true, bookmarkCount: 0, reply: [reply3,reply2,reply1], tilUrl: "")
var posting6 = PostingInfo(user: user1, category: "잡담", content: "dd", createTime: Date(), updateTime: Date(),contentImage: UIImage(named: "defaultProfileImage"),bookmark: false, bookmarkCount: 0, reply: [reply2], tilUrl: "") // key -> kimseoni
var posting7 = PostingInfo(user: user1, category: "잡담", content: "아니에요", createTime: Date(), updateTime: Date(),contentImage: UIImage(named: "defaultProfileImage"),bookmark: false, bookmarkCount: 0, reply: [reply1,reply4,reply2,reply2], tilUrl: "")

var reply1 = ReplyInfo(user: user1, content: "빡세요", createTime: Date(), updateTime: Date())
var reply2 = ReplyInfo(user: user2, content: "ㅠㅠ", createTime: Date(), updateTime: Date())
var reply3 = ReplyInfo(user: user4, content: "fa", createTime: Date(), updateTime: Date())
var reply4 = ReplyInfo(user: user2, content: "xcxz", createTime: Date(), updateTime: Date())
var reply5 = ReplyInfo(user: user3, content: "ㅋㅋsad", createTime: Date(), updateTime: Date())
var reply6 = ReplyInfo(user: user1, content: "rwqrqwr", createTime: Date(), updateTime: Date())

var data = [posting1, posting2, posting3, posting4, posting5, posting6, posting7]
var filter : [PostingInfo] = []
var indexlist : [Int] = []
