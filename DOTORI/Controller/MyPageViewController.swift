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
    var indexlist:[Int] = []
    var urlText: String?
    var selectedUserName : String? //디테일페이지에서 클릭한 프로필의 유저 이름
    var selectedIndex : Int? // 마이페이지에서 클릭한 게시물 인덱스
    let webView = WKWebView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    @IBOutlet weak var mySetting: UIButton!
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
    
    @IBAction func mySetting(_ sender: UIButton) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lightMode = UIAction(title: "라이트모드", image: UIImage(systemName: "lightbulb"), handler: { _ in
            self.view.window?.overrideUserInterfaceStyle = .light
            self.titleLabel.textColor = UIColor.black
        })
        let darkMode = UIAction(title: "다크모드", image: UIImage(systemName: "lightbulb.fill"), handler: { _ in
            self.view.window?.overrideUserInterfaceStyle = .dark
            self.titleLabel.textColor = UIColor.white
        })
        let settingMenu = UIMenu(title: "", children: [lightMode, darkMode])
        mySetting.menu = settingMenu
        if let text = selectedUserName { name.text = text }
        for i in 0..<data.count {
            if data[i].user.name == user1.name {
                indexlist.append(i)
                myPostings.append(data[i])
            }
        }
        loadTitleAccount()
        loadAccount()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    // Navigation Item 설정
    func loadTitleAccount() {
        titleLabel.textColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        titleLabel.text = user1.nickname
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    // 계정 정보 불러오기
    func loadAccount() {
        // 이미지 설정
        profileImage.image = user1.profileImage
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        name.text = user1.name
        userIntro.text = user1.userIntro
        postingCount.text = String(myPostings.count)
        blogUrl.titleLabel?.text = user1.blogUrl
        githubUrl.titleLabel?.text = user1.githubUrl
        print("계정 정보 불러오기")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateMyPageSegue" {
            if let updateMyPageVC = segue.destination as? UpdateMyPageViewController {
                updateMyPageVC.delegate = self
            }
            print("페이지 이동 : 마이페이지 ➡️ 마이페이지 수정")
        } else if segue.identifier == "MyPageToDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
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
        let delete = UIAction(title: "게시물 삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
            data.remove(at: self.indexlist[indexPath.row])
            self.myPostings.remove(at: indexPath.row)
            self.indexlist.remove(at: indexPath.row)
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
            self.postingCount.text = String(self.myPostings.count)
        })
        let menu = UIMenu(title: "", children: [delete])
        cell.postingSetting.menu = menu
        return cell
    }
    
    @objc func bookmarkChange (_ sender : UIButton){
        self.tableView.reloadData()
        if myPostings[sender.tag].bookmark == true {
            myPostings[sender.tag].bookmark = false
            print("북마크 취소")
        }
        else {
            myPostings[sender.tag].bookmark = true
            print("북마크 저장")
        }
    }
    
    func handleShareButtonTap() {
        let shareText: String = "공유"
        var shareObject = [Any]()
        shareObject.append(shareText)
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        print("버튼 클릭: 공유")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 선택시 함수
        selectedIndex = indexlist[indexPath.row]
        performSegue(withIdentifier: "MyPageToDetail", sender: self)
        print("페이지 이동 : 마이페이지 ➡️ 디테일페이지")
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
        loadTitleAccount()
        loadAccount()
        print("📣 계정 정보 업데이트")
    }
}


class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var urlText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL(urlText ?? "www.google.com")
        print("📺 웹뷰 띄우기")

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
