//
//  Dummy.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import Foundation
import UIKit

var user1 = UserInfo(profileImage :UIImage(named: "User1"), name: "김서온", nickname: "김서오니", githubUrl: "github.com/anfgbwl", blogUrl: "ahrzosel.tistory.com/", userIntro: "끝까지 살아남을꺼야…")
var user2 = UserInfo(profileImage :UIImage(named: "User2"), name: "이찬호", nickname: "lcho3878", githubUrl: "github.com/lcho3878/", blogUrl: "velog.io/@leech3878", userIntro: "열심히하자")
var user3 = UserInfo(profileImage :UIImage(named: "User3"), name: "이대현", nickname: "hidaehyun", githubUrl: "github.com/hidaehyunlee", blogUrl: "velog.io/@hidaehyunlee", userIntro: "노에어컨.. 노코딩.. 🌬️")
var user4 = UserInfo(profileImage :UIImage(named: "User4"), name: "박유경", nickname: "hiyukyung", githubUrl: "github.com/ohAkse", blogUrl: "velog.io/@segassdc", userIntro: "화이팅")
var user5 = UserInfo(profileImage :UIImage(named: "defaultProfileImage"),name: "박지근", nickname: "지끈지끈", githubUrl: "github.com/Kyletube", blogUrl: "kylestory.tistory.com/", userIntro: "이거…왜 돌아가지?")

var posting1 = PostingInfo(user: user1, category: "잡담", content: "이번 팀프로젝트는 SNS 앱 만들기!\n우리 팀은 오늘 12시까지 개발합니다요~ 파이팅!!", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "defaultProfileImage"), bookmark: false, bookmarkCount: 0, reply: [reply1, reply2, reply3], tilUrl: "")
var posting2 = PostingInfo(user: user2, category: "잡담", content: "게시물 삭제 드디어 성공했습니다용~!!", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply1, reply4, reply2, reply3], tilUrl: "")
var posting3 = PostingInfo(user: user3, category: "질문", content: "오늘 저녁 뭐먹을까요?", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply3, reply2, reply4, reply2], tilUrl: "")
var posting4 = PostingInfo(user: user4, category: "고양이방", content: "나만 고양이 없어어어", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply3, reply2, reply4, reply2], tilUrl: "")
var posting5 = PostingInfo(user: user5, category: "TIL", content: "UserDefault", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "defaultProfileImage"), bookmark: true, bookmarkCount: 0, reply: [reply3, reply2, reply1], tilUrl: "")
var posting6 = PostingInfo(user: user1, category: "잡담", content: "여름 언제 지나갈까요.... 이번달 전기세 겁나 많이 나올거같아요 ㅋㅋㅋㅋㅋㅋㅋ", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "defaultProfileImage"), bookmark: false, bookmarkCount: 0, reply: [reply2], tilUrl: "")
var posting7 = PostingInfo(user: user3, category: "잡담", content: "오늘 축구한판 뛰고 오겠습니다.", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "image2"), bookmark: false, bookmarkCount: 0, reply: [reply1, reply4, reply2, reply2], tilUrl: "")
var posting8 = PostingInfo(user: user1, category: "고양이방", content: "우리 두부 자랑합니다.", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "cat"), bookmark: false, bookmarkCount: 0, reply: [reply7, reply8, reply9, reply10], tilUrl: "")
var posting9 = PostingInfo(user: user1, category: "잡담", content: "나는 고양이 있지롱~^0^", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "cat2"), bookmark: false, bookmarkCount: 0, reply: [reply8, reply5, reply7], tilUrl: "")
var posting10 = PostingInfo(user: user5, category: "TIL", content: "오토레이아웃: 진짜 빡세다", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "study"), bookmark: true, bookmarkCount: 0, reply: [reply2, reply1], tilUrl: "")

var reply1 = ReplyInfo(user: user1, content: "빡세요", createTime: Date(), updateTime: Date())
var reply2 = ReplyInfo(user: user2, content: "ㅠㅠ", createTime: Date(), updateTime: Date())
var reply3 = ReplyInfo(user: user4, content: "가보자고용~~~~", createTime: Date(), updateTime: Date())
var reply4 = ReplyInfo(user: user2, content: "아 너무 재밌다~~~~", createTime: Date(), updateTime: Date())
var reply5 = ReplyInfo(user: user3, content: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", createTime: Date(), updateTime: Date())
var reply6 = ReplyInfo(user: user1, content: "꺄아아아아아ㅏㅇ 오늘 너무 힘듭니다... 화이팅...", createTime: Date(), updateTime: Date())
var reply7 = ReplyInfo(user: user2, content: "미쳤다 꿀귀", createTime: Date(), updateTime: Date())
var reply8 = ReplyInfo(user: user3, content: "두부야아ㅏㅏㅏㅏㅏㅏ", createTime: Date(), updateTime: Date())
var reply9 = ReplyInfo(user: user4, content: "ㅠㅠㅠㅠㅠ겸둥이ㅠㅠㅠ", createTime: Date(), updateTime: Date())
var reply10 = ReplyInfo(user: user5, content: "우주 최강 고양이😻", createTime: Date(), updateTime: Date())

var data = [posting1, posting2, posting3, posting4, posting5, posting6, posting7, posting8, posting9, posting10]
var filter : [PostingInfo] = []
var indexlist : [Int] = []
var search : [PostingInfo] = []
