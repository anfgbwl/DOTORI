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
var user3 = UserInfo(profileImage :UIImage(named: "User3"), name: "이대현", nickname: "hidaehyunlee", githubUrl: "github.com/hidaehyunlee", blogUrl: "velog.io/@hidaehyunlee", userIntro: "노에어컨.. 노코딩.. 🌬️")
var user4 = UserInfo(profileImage :UIImage(named: "User4"), name: "박유경", nickname: "hiyukyung", githubUrl: "github.com/ohAkse", blogUrl: "velog.io/@segassdc", userIntro: "화이팅")
var user5 = UserInfo(profileImage :UIImage(named: "defaultProfileImage"),name: "박지근", nickname: "지끈지끈", githubUrl: "github.com/Kyletube", blogUrl: "kylestory.tistory.com/", userIntro: "이거…왜 돌아가지?")

var posting1 = PostingInfo(user: user1, category: "잡담", content: "이번 팀프로젝트는 SNS 앱 만들기!\n우리 팀은 오늘 12시까지 개발합니다요~", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "defaultProfileImage"), bookmark: false, bookmarkCount: 0, reply: [reply1_1, reply1_2, reply1_3, reply6], tilUrl: "")
var posting2 = PostingInfo(user: user2, category: "잡담", content: "게시물 삭제 드디어 성공했습니다용~!!", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply2_1, reply2_2], tilUrl: "")
var posting3 = PostingInfo(user: user3, category: "질문", content: "오늘 저녁 뭐먹을까요?", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply3], tilUrl: "")
var posting4 = PostingInfo(user: user4, category: "고양이방", content: "나만 고양이 없어어어", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: false, bookmarkCount: 0, reply: [reply4_1, reply4_3, reply4_2], tilUrl: "")
var posting5 = PostingInfo(user: user5, category: "TIL", content: kyletubeTIL, createTime: Date(), updateTime: Date(), contentImage: UIImage(named: ""), bookmark: true, bookmarkCount: 0, reply: [], tilUrl: "")
var posting6 = PostingInfo(user: user3, category: "잡담", content: "오늘 축구한판 뛰고 오겠습니다.", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "image2"), bookmark: false, bookmarkCount: 0, reply: [reply7_1, reply7_2], tilUrl: "")
var posting7 = PostingInfo(user: user1, category: "고양이방", content: "우리 두부 자랑합니다.", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "cat"), bookmark: false, bookmarkCount: 0, reply: [reply8, reply9, reply10], tilUrl: "")
var posting8 = PostingInfo(user: user1, category: "고양이방", content: "나는 고양이 있지롱~^0^", createTime: Date(), updateTime: Date(), contentImage: UIImage(named: "cat2"), bookmark: false, bookmarkCount: 0, reply: [reply8, reply10, reply11, reply12, reply13], tilUrl: "")

var reply1_1 = ReplyInfo(user: user4, content: "빡세요", createTime: Date(), updateTime: Date())
var reply1_2 = ReplyInfo(user: user2, content: "농담이시죠?", createTime: Date(), updateTime: Date())
var reply1_3 = ReplyInfo(user: user3, content: "자리에 착석해주세요 여러분", createTime: Date(), updateTime: Date())
var reply2_1 = ReplyInfo(user: user2, content: "저는 천재입니다.", createTime: Date(), updateTime: Date())
var reply2_2 = ReplyInfo(user: user5, content: "찬호님은 천재십니다.", createTime: Date(), updateTime: Date())
var reply3 = ReplyInfo(user: user4, content: "도토리묵 가시죠 ~🍔", createTime: Date(), updateTime: Date())
var reply4_1 = ReplyInfo(user: user2, content: "프사 고양이 아니세요?", createTime: Date(), updateTime: Date())
var reply4_2 = ReplyInfo(user: user4, content: "저희 두부 보러 오세요", createTime: Date(), updateTime: Date())
var reply4_3 = ReplyInfo(user: user4, content: "상어인데요", createTime: Date(), updateTime: Date())
var reply6 = ReplyInfo(user: user1, content: "꺄아아아아아ㅏㅇ 오늘 너무 힘듭니다... 화이팅...", createTime: Date(), updateTime: Date())
var reply7_1 = ReplyInfo(user: user3, content: "남양주의 이강인 출격", createTime: Date(), updateTime: Date())
var reply7_2 = ReplyInfo(user: user1, content: "코딩 안하세요 ? ? ? ? ? ? ?", createTime: Date(), updateTime: Date())
var reply8 = ReplyInfo(user: user3, content: "두부야아ㅏㅏㅏㅏㅏㅏ", createTime: Date(), updateTime: Date())
var reply9 = ReplyInfo(user: user2, content: "ㅠㅠㅠ겸둥이ㅠㅠㅠ", createTime: Date(), updateTime: Date())
var reply10 = ReplyInfo(user: user5, content: "우주 최강 고양이😻", createTime: Date(), updateTime: Date())
var reply11 = ReplyInfo(user: user3, content: "사실 저도 고양이 있어요", createTime: Date(), updateTime: Date())
var reply12 = ReplyInfo(user: user2, content: "저도 집사인데 ㅋㅋ", createTime: Date(), updateTime: Date())
var reply13 = ReplyInfo(user: user4, content: "나만 고양이 없어", createTime: Date(), updateTime: Date())

var data = [posting1, posting2, posting3, posting4, posting5, posting6, posting7, posting8]

var filter : [PostingInfo] = []
var filterindex : [Int] = []
var search : [PostingInfo] = []
var searchindex : [Int] = []
var bookmark : [PostingInfo] = []
var bookmarkindex : [Int] = []

var indexlist : [Int] = []
var loginUser = user1

let kyletubeTIL = """
Git은 분산 버전 관리 시스템으로, 코드 변경 이력을 관리하고 여러 개발자가 동시에 작업하는 경우에 수월하게 협업할 수 있게 해준다.
GitHub는 Git을 기반으로해서 다른 개발자들과 협업하며 관리할 수 있는 기능을 제공한다.

1. Git

분산 버전 관리 시스템 Git은 코드 변경 이력을 추적하고 관리하는 데에 주로 사용된다.
Git의 핵심 개념 중 하나는 Repository(저장소) 이다.
Repositoy는 코드와 그에대한 변경 이력을 저장하는 공간으로, 개발자는 로컬 저장소와 원격 저장소를 사용하여 작업한다.
Git은 변경 이력을 Commit(커밋) 단위로 관리하며, 변경 사항을 추적하고 돌아갈 수 있는 유연성을 제공한다.

2. GitHub

GitHub는 Git을 기반으로한 웹 호스팅 서비스로, 개발자들이 Git 저장소를 원격으로 웹에 올려서 협업할 수 있는 플랫폼이다.
GitHub를 통해 여러 개발자가 동시에 작업할 수 있으며, 각자의 변경 내용을 관리하고 Mergy(병합)할 수 있다.
또한, 프로젝트 관리 기능을 제공하여 효율적인 협업을 도모한다.
"""
