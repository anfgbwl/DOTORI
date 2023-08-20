//
//  ViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    var key : String = "전체"
    func resetfilterindex () { // filterindex를 전체 dataindex로 초기화하는 함수
        for i in 0..<data.count {
            filterindex.append(i)
        }
    }
    func UpdateFilter (_ category : String) { // filter를 전체 data로 초기화하는 함수
        filter = []
        filterindex = []
        for i in 0..<data.count{
            if data[i].category == category{
                filterindex.append(i)
                filter.append(data[i])
            }
        }
        self.key = category
        self.menuButton.setTitle("도토리묵", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.key == "전체" {
            filter = data
            self.resetfilterindex()
        }
        else {
            UpdateFilter(self.key)
        }
        mainTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filter = data
        resetfilterindex()
        // Do any additional setup after loading the view.
        let all = UIAction(title: "전체", handler: { _ in
            self.menuButton.setTitle("도토리묵", for: .normal)
            filter = data
            self.key = "전체"
            self.resetfilterindex()
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let smalltalk = UIAction(title: "잡담", handler: { _ in
            self.UpdateFilter("잡담")
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let til = UIAction(title: "TIL", handler: { _ in
            self.UpdateFilter("TIL")
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let cat = UIAction(title: "고양이방", handler: { _ in
            self.UpdateFilter("고양이방")
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let qna = UIAction(title: "질문", handler: { _ in
            self.UpdateFilter("질문")
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let menu = UIMenu(title: "", children: [all, smalltalk, til, cat, qna])
        menuButton.menu = menu
        menuButton.setTitle("도토리묵", for: .normal)
        menuButton.titleLabel?.font = UIFont(name: "JejuHallasanOTF", size: 30)
    }
    var selectedIndex : Int?
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return filter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }
        let posting = filter[indexPath.row]
        cell.setupUI(posting: posting)
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkChange), for: .touchUpInside)
        
        if filter[indexPath.row].bookmark == true {
            let bookmarkadd = UIAction(title: "북마크 해제하기", image: UIImage(systemName: "bookmark.fill"), handler: { _ in
                filter[indexPath.row].bookmark = false
                self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
            })
            let menu = UIMenu(title: "", children: [bookmarkadd])
            cell.cellSettingButton.menu = menu
        }
        else {
            let bookmarkadd = UIAction(title: "북마크 추가하기", image: UIImage(systemName: "bookmark"), handler: { _ in
                filter[indexPath.row].bookmark = true
                self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
            })
            let menu = UIMenu(title: "", children: [bookmarkadd])
            cell.cellSettingButton.menu = menu
        }
        
        if loginUser.name == posting.user.name {
            let delete = UIAction(title: "나의 게시물 삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
                data.remove(at: filterindex[indexPath.row])
                    if self.key == "전체" {
                        filter = data
                        self.resetfilterindex()
                    }
                    else {
                        self.UpdateFilter(self.key)
                    }
                
                self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
            })
            let menu = UIMenu(title: "", children: [delete])
            cell.cellSettingButton.menu = menu
        }
        
        return cell
    }
    @objc func bookmarkChange (_ sender : UIButton){
        self.mainTableView.reloadData()
        if filter[sender.tag].bookmark == true {
            filter[sender.tag].bookmark = false
        }
        else {
            filter[sender.tag].bookmark = true
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 선택시 함수
        selectedIndex = filterindex[indexPath.row]
        performSegue(withIdentifier: "HomeToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "HomeToDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.selectedIndex = selectedIndex!

            }
        }
    }
}

