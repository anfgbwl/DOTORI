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
    var urlText: String?
    var selectedUserName : String? //디테일페이지에서 클릭한 프로필의 유저 이름
    var selectedIndex : Int? // 마이페이지에서 클릭한 게시물
    let webView = WKWebView()
    
    @IBOutlet weak var mySetting: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userIntro: UILabel!
    @IBOutlet weak var posting: UILabel!
    @IBOutlet weak var postingCount: UILabel!
    @IBOutlet weak var blog: UILabel!
    @IBOutlet weak var blogUrl: UIButton!
    @IBOutlet weak var github: UILabel!
    @IBOutlet weak var githubUrl: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func mySetting(_ sender: UIBarButtonItem) {
        print("버튼 클릭: mySetting")
    }
    
    @IBAction func blogUrl(_ sender: UIButton) {
        let urlText = user1.blogUrl
        let WebVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            WebVC.urlText = urlText
            present(WebVC, animated: true, completion: nil)
    }
    
    @IBAction func githubUrl(_ sender: UIButton) {
        let urlText = user1.githubUrl
        let WebVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            WebVC.urlText = urlText
            present(WebVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let text = selectedUserName { name.text = text }
        loadTitleAccount()
        loadAccount()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    // Navigation Item 설정
    func loadTitleAccount() {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = user1.nickname
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    // 계정 정보 불러오기
    func loadAccount() {
        // 이미지 설정
        profileImage.image = UIImage(named: "defaultProfileImage")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        name.text = user1.name
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateMyPageSegue" {
            if let updateMyPageVC = segue.destination as? UpdateMyPageViewController {
                updateMyPageVC.delegate = self
            }
        } else if segue.identifier == "MyPageToDetail" {
                if let destinationVC = segue.destination as? MyPageViewController {
                    destinationVC.selectedIndex = selectedIndex!
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateMyPageSegue" {
            if let updateMyPageVC = segue.destination as? UpdateMyPageViewController {
                updateMyPageVC.delegate = self
            }
        } else if segue.identifier == "MyPageToDetail" {
                if let destinationVC = segue.destination as? MyPageViewController {
                    destinationVC.selectedIndex = selectedIndex!
                }
            }
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
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkChange), for: .touchUpInside)
        cell.shareButtonTapped = { [weak self] in
            self?.handleShareButtonTap()
        }
        return cell
    }
    
    @objc func bookmarkChange (_ sender : UIButton){
        self.tableView.reloadData()
        if filter[sender.tag].bookmark == true {
            filter[sender.tag].bookmark = false
        }
        else {
            filter[sender.tag].bookmark = true
        }
    }
    
    func handleShareButtonTap() {
        let shareText: String = "공유"
        var shareObject = [Any]()
        shareObject.append(shareText)
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 선택시 함수
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "MyPageToDetail", sender: self)
    }
}

extension MyPageViewController: UpdateMyPageDelegate {
    func updateUserInformation(profileImage: UIImage?, name: String, nickname: String, githubUrl: String, blogUrl: String, userIntro: String) {
        user1.profileImage = profileImage
        user1.name = name
        user1.nickname = nickname
        user1.githubUrl = githubUrl
        user1.blogUrl = blogUrl
        user1.userIntro = userIntro
        tableView.reloadData()
        print(user1.blogUrl)
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
        let urlString = "http://" + url
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
