//
//  Dummy.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import Foundation

var user1 = UserInfo(name: "김서온", nickname: "김서오니", githubUrl: "https://github.com/anfgbwl", blogUrl: "https://ahrzosel.tistory.com/", userIntro: "끝까지 살아남을꺼야…")
var user2 = UserInfo(name: "이찬호", nickname: "lcho3878", githubUrl: "https://github.com/lcho3878/", blogUrl: "https://velog.io/@leech3878", userIntro: "열심히하자")
var user3 = UserInfo(name: "이대현", nickname: "hidaehyun", githubUrl: "https://github.com/hidaehyunlee", blogUrl: "https://velog.io/@hidaehyunlee", userIntro: "노에어컨.. 노코딩.. 🌬️")
var user4 = UserInfo(name: "박유경", nickname: "hiyukyung", githubUrl: "https://github.com/ohAkse", blogUrl: "https://velog.io/@segassdc", userIntro: "화이팅")
var user5 = UserInfo(name: "박지근", nickname: "지끈지끈", githubUrl: "https://github.com/Kyletube", blogUrl: "https://kylestory.tistory.com/", userIntro: "이거…왜 돌아가지?")

var posting1 = PostingInfo(user: user1, category: "잡담", content: "아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요아니에요", createTime: Date(), updateTime: Date(), bookmark: false, bookmarkCount: 0, reply: [reply1], tilUrl: "")
var posting2 = PostingInfo(user: user2, category: "잡담", content: "타닥타닥", createTime: Date(), updateTime: Date(), bookmark: false, bookmarkCount: 0, reply: [], tilUrl: "")
var posting3 = PostingInfo(user: user3, category: "질문", content: "저녁 뭐먹을까요?", createTime: Date(), updateTime: Date(), bookmark: false, bookmarkCount: 0, reply: [], tilUrl: "")
var posting4 = PostingInfo(user: user4, category: "고양이방", content: "야옹", createTime: Date(), updateTime: Date(), bookmark: false, bookmarkCount: 0, reply: [], tilUrl: "")
var posting5 = PostingInfo(user: user5, category: "TIL", content: "UserDefault", createTime: Date(), updateTime: Date(), bookmark: true, bookmarkCount: 0, reply: [], tilUrl: "")

var reply1 = ReplyInfo(user: user1, content: "빡세요", createTime: Date(), updateTime: Date())

var data = [posting1, posting2, posting3, posting4, posting5]
