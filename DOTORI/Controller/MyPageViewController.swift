//
//  MyPageViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit
import WebKit

class MyPageViewController: UIViewController, WKNavigationDelegate {
    
    var myPostings: [PostingInfo] = []
    var selectedUserName : String? //디테일페이지에서 클릭한 프로필의 유저 이름
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mySetting: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var userIntro: UILabel!
    @IBOutlet weak var posting: UILabel!
    @IBOutlet weak var postingCount: UILabel!
    @IBOutlet weak var blog: UILabel!
    @IBOutlet weak var blogUrl: UIButton!
    @IBOutlet weak var github: UILabel!
    @IBOutlet weak var githubUrl: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func mySetting(_ sender: UIButton) {
    }
    
    @IBAction func blogUrl(_ sender: UIButton) {
        if let blogUrl = URL(string: "https://ahrzosel.tistory.com") {
            let webView = WKWebView(frame: view.bounds)
            webView.navigationDelegate = self
            view.addSubview(webView)
            
            let request = URLRequest(url: blogUrl)
            webView.load(request)
        }
    }
    
    @IBAction func githubUrl(_ sender: UIButton) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = selectedUserName
        {
            name.text = text
        }
        
        
        /*
        // 유저 정보 가져오기(UserInfo, PostingInfo Codable 프로토콜 준수)
        if let userInfoData = UserDefaults.standard.data(forKey: "userInfo"),
           let userInfo = try? JSONDecoder().decode(UserInfo.self, from: userInfoData) {
            // 마이페이지 업데이트
            name.text = userInfo.name
            nickname.text = userInfo.nickname
            userIntro.text = userInfo.userIntro
            
            if let imageData = userInfo.profileImage as? Data,
               let image = UIImage(data: imageData) {
                profileImage.image = image
            }
        }
         */

        // 초기 이미지 설정
        if let image = UIImage(named: "defaultProfileImage") {
                   profileImage.image = image
               }
        // 이미지뷰 규격 설정(동그라미)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
                profileImage.clipsToBounds = true
        
//        let posting = PostingInfo()
//        posting.profileImage = UIImage(named: "defaultProfileImage")
//        posting.name = "테스트"
//        posting.nickname = "Test"
//        posting.content = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
//        posting.contentImage = "https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Ff1dda5e3-a965-4609-bb79-f3679c2aa52d%2FSNS_%25E1%2584%258B%25E1%2585%25A2%25E1%2586%25B8_%25E1%2584%2586%25E1%2585%25A1%25E1%2586%25AB%25E1%2584%2583%25E1%2585%25B3%25E1%2586%25AF%25E1%2584%2580%25E1%2585%25B5.005.png?table=block&id=997b126a-0213-418c-aa69-59569b946c79&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=2000&userId=c88c14ea-d30e-4675-8fa5-7ab3b296af4d&cache=v2"
//        myPostings.append(posting)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }

}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPostings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath) as! MyPostingTableViewCell
//        let posting = user1
//        cell.profileImage.image = UIImage(named: "defaultProfileImage")
//        cell.name.text = posting.name
//        cell.nickname.text = posting.nickname
//        cell.content.text = posting.content
//        cell.contentImage.image = UIImage(named: "defaultProfileImage")

        return cell
    }
}

class MyPostingTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var contentImage: UIImageView!
    
    
}
