//
//  BookmarkViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    var selectedIndex : Int?
    var key : String = "전체"
    var bookmarkFilter :[ PostingInfo ] = []
    var bookmarkFilterindex : [Int] = []
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bookmarkView: UITableView!
    
    func UpdateBookmark () {
        bookmark = []
        bookmarkindex = []
        for i in 0..<data.count {
            if data[i].bookmark == true {
                bookmark.append(data[i])
                bookmarkindex.append(i)
            }
        }
    }
    
    func UpdatebookmarkFilter (_ category : String ) {
        bookmarkFilter = []
        bookmarkFilterindex = []
        if category == "전체" {
            for i in 0..<data.count {
                if data[i].bookmark == true {
                    bookmarkFilter.append(data[i])
                    bookmarkFilterindex.append(i)
                }
            }
        }
        else{
            for i in 0..<data.count {
                if data[i].category == category && data[i].bookmark == true {
                    bookmarkFilter.append(data[i])
                    bookmarkFilterindex.append(i)
                }
            }
        }
        key = category
        self.menuButton.setTitle("도토리묵", for: .normal)
        BookmarkTableHidden()
    }
    
    func BookmarkTableHidden () {
        if bookmarkFilter.count == 0 {
            bookmarkView.isHidden = true
        }
        else {
            bookmarkView.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        UpdatebookmarkFilter(self.key)
        BookmarkTableHidden()
        bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateBookmark()
        bookmarkFilter = bookmark
        bookmarkFilterindex = bookmarkindex
        let all = UIAction(title: "전체", handler: { [self] _ in
            UpdatebookmarkFilter("전체")
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let smalltalk = UIAction(title: "잡담", handler: { [self] _ in
            UpdatebookmarkFilter("잡담")
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let til = UIAction(title: "TIL", handler: { [self] _ in
            UpdatebookmarkFilter("TIL")
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let cat = UIAction(title: "고양이방", handler: { [self] _ in
            UpdatebookmarkFilter("고양이방")
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let qna = UIAction(title: "질문", handler: { [self] _ in
            UpdatebookmarkFilter("질문")
            bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let menu = UIMenu(title: "", children: [all, smalltalk, til, cat, qna])
        menuButton.menu = menu
        menuButton.setTitle("도토리묵", for: .normal)
        menuButton.titleLabel?.font = UIFont(name: "JejuHallasanOTF", size: 30)
    }
}
extension BookmarkViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }
        let posting = bookmarkFilter[indexPath.row]
        cell.setupUI(posting: posting)
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkChange), for: .touchUpInside)
        return cell
    }
    @objc func bookmarkChange (_ sender : UIButton){
        if bookmarkFilter[sender.tag].bookmark == true {
            bookmarkFilter[sender.tag].bookmark = false
        }
        self.bookmarkView.reloadSections(IndexSet(0...0), with: .automatic)
        self.viewWillAppear(true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = bookmarkFilterindex[indexPath.row]
        performSegue(withIdentifier: "BookmarkToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookmarkToDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.selectedIndex = selectedIndex!
            }
        }
    }
}
