//
//  BookmarkViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bookmarkView: UITableView!
    func MakeFilterBookmark () {
        filter = []
        for i in 0..<data.count {
            if data[i].bookmark == true {
                filter.append(data[i])
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        MakeFilterBookmark()
        if filter.count == 0 {
            bookmarkView.isHidden = true
        }
        else {
            bookmarkView.isHidden = false
        }
        bookmarkView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let all = UIAction(title: "전체", handler: { [self] _ in
            MakeFilterBookmark()
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let smalltalk = UIAction(title: "잡담", handler: { [self] _ in
            filter = []
            for i in 0..<data.count {
                if data[i].bookmark == true && data[i].category == "잡담" {
                    filter.append(data[i])
                }
            }
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let til = UIAction(title: "TIL", handler: { [self] _ in
            filter = []
            for i in 0..<data.count {
                if data[i].bookmark == true && data[i].category == "TIL" {
                    filter.append(data[i])
                }
            }
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let cat = UIAction(title: "고양이방", handler: { [self] _ in
            filter = []
            for i in 0..<data.count {
                if data[i].bookmark == true && data[i].category == "고양이방" {
                    filter.append(data[i])
                }
            }
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let qna = UIAction(title: "질문", handler: { [self] _ in
            filter = []
            for i in 0..<data.count {
                if data[i].bookmark == true && data[i].category == "질문" {
                    filter.append(data[i])
                }
            }
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let menu = UIMenu(title: "", children: [all, smalltalk, til, cat, qna])
        menuButton.menu = menu
    }
    override func viewWillDisappear(_ animated: Bool) {
        filter = data
        bookmarkView.reloadData()
    }
}
extension BookmarkViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }
        let posting = filter[indexPath.row]
        cell.setupUI(posting: posting)
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkChange), for: .touchUpInside)
        return cell
    }
    @objc func bookmarkChange (_ sender : UIButton){
        if filter[sender.tag].bookmark == true {
            filter[sender.tag].bookmark = false
        }
        filter.remove(at: sender.tag)
        self.bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        self.viewWillAppear(true)
    }
    
    
}
