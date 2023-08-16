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
    let webView = WKWebView()

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
        if let blogUrlText = blogUrl.titleLabel?.text {
            let blogWebVC = storyboard?.instantiateViewController(withIdentifier: "blogWebViewController") as! blogWebViewController
            blogWebVC.blogUrlText = blogUrlText
            present(blogWebVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func githubUrl(_ sender: UIButton) {
        if let githubUrlText = githubUrl.titleLabel?.text {
            let githubWebVC = storyboard?.instantiateViewController(withIdentifier: "githubWebViewController") as! githubWebViewController
            githubWebVC.githubUrlText = githubUrlText
            present(githubWebVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAccount()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    
    // 계정 정보 불러오기
    func loadAccount() {
       
        // 이미지 설정
        profileImage.image = UIImage(named: "defaultProfileImage")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        name.text = user1.name
        nickname.text = user1.nickname
        userIntro.text = user1.userIntro
        
        for posting in data {
            if posting.user.name == user1.name {
                myPostings.append(posting)
            }
        }
        postingCount.text = String(myPostings.count)
        blogUrl.titleLabel?.text = user1.blogUrl
        githubUrl.titleLabel?.text = user1.githubUrl
    }

}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPostings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath) as! MyPostingTableViewCell
        let posting = myPostings[indexPath.row]
        cell.profileImage.image = posting.user.profileImage ?? UIImage(named: "defaultProfileImage")
        cell.name.text = posting.user.name
        cell.nickname.text = posting.user.nickname
        cell.createTime.text = posting.createTime.GetCurrentTime()
        cell.content.text = posting.content
        cell.contentImage.image = posting.contentImage ?? UIImage(named: "defaultProfileImage")
        
        // (오류) 풀 다운 버튼 해결해야 함
        cell.postingSetting.addTarget(cell, action: #selector(cell.selectedPostingSetting(_:)), for: .touchUpInside)

        return cell
    }
    
}

class MyPostingTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var postingSetting: UIButton!
    
    // (오류) 풀 다운 버튼 해결해야 함
    @objc func selectedPostingSetting(_ sender: UIButton) {
        print("버튼 클릭: postingSetting")
        let delete = UIAction(title: "게시물 삭제", image: UIImage(systemName: "trash"), handler: { _ in print("게시물 삭제") })
        postingSetting.menu = UIMenu(title: "",
                                     image: UIImage(systemName: "trash.fill"),
                                     identifier: nil,
                                     options: .displayInline,
                                     children: [delete])
        postingSetting.showsMenuAsPrimaryAction = true
        postingSetting.changesSelectionAsPrimaryAction = true
    }
    
}

class blogWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var blogUrlText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBlogURL(blogUrlText ?? "www.google.com")
    }
    
    func loadBlogURL(_ url: String) {
        guard let blogUrlText = URL(string: url) else {
            return
        }
        let request = URLRequest(url: blogUrlText)
        webView.load(request)
    }
}

class githubWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var githubUrlText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGithubURL(githubUrlText ?? "www.google.com")
    }
    
    func loadGithubURL(_ url: String) {
        guard let githubUrlText = URL(string: url) else {
            return
        }
        let request = URLRequest(url: githubUrlText)
        webView.load(request)
    }
}
