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
        if let urlText = blogUrl.titleLabel?.text {
            let WebVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            WebVC.urlText = urlText
            present(WebVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func githubUrl(_ sender: UIButton) {
        if let urlText = githubUrl.titleLabel?.text {
            let WebVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            WebVC.urlText = urlText
            present(WebVC, animated: true, completion: nil)
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

extension MyPageViewController : UITextViewDelegate {
            
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPostings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath) as! MyPostingTableViewCell
        let posting = myPostings[indexPath.row]
        cell.setupUI(posting: posting)

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
    
    func setupUI(posting: PostingInfo) {
        profileImage.image = posting.user.profileImage ?? UIImage(named: "defaultProfileImage")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        name.text = posting.user.name
        nickname.text = posting.user.nickname
        createTime.text = posting.createTime.GetCurrentTime()
        content.text = posting.content
        contentImage.image = posting.contentImage ?? UIImage(named: "defaultProfileImage")
        contentImage.layer.cornerRadius = 10
        contentImage.clipsToBounds = true

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        print("버튼 클릭: postingSetting")
        let seletedpostingSetting = {(action: UIAction) in
            }
        postingSetting.menu = UIMenu(children: [
            UIAction(title: "게시물 삭제", image: UIImage(systemName: "trash"),attributes: .destructive, handler: seletedpostingSetting)])
        postingSetting.showsMenuAsPrimaryAction = true
        postingSetting.changesSelectionAsPrimaryAction = false
    }
    
}

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var urlText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlText ?? "www.google.com")

    }
    
    func loadURL(_ url: String) {
        guard let urlText = URL(string: url) else {
            return
        }
        let request = URLRequest(url: urlText)
        webView.load(request)
    }
}
