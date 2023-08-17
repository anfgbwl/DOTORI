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
    func resetindex () {
        for i in 0..<data.count {
            indexlist.append(i)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        filter = data
        resetindex()
        mainTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filter = data
        resetindex()
        // Do any additional setup after loading the view.
        //더미데이터들
        let all = UIAction(title: "전체", handler: { _ in
            filter = data
            self.resetindex()
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let smalltalk = UIAction(title: "잡담", handler: { _ in
            filter = []
            indexlist.removeAll()
            for i in 0..<data.count{
                if data[i].category == "잡담"{
                    indexlist.append(i)
                    filter.append(data[i])
                }
            }
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let til = UIAction(title: "TIL", handler: { _ in
            filter = []
            indexlist.removeAll()
            for i in 0..<data.count{
                if data[i].category == "TIL"{
                    indexlist.append(i)
                    filter.append(data[i])
                }
            }
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let cat = UIAction(title: "고양이방", handler: { _ in
            filter = []
            indexlist.removeAll()
            for i in 0..<data.count{
                if data[i].category == "고양이방"{
                    indexlist.append(i)
                    filter.append(data[i])
                }
            }
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let qna = UIAction(title: "질문", handler: { _ in
            filter = []
            indexlist.removeAll()
            for i in 0..<data.count{
                if data[i].category == "질문"{
                    indexlist.append(i)
                    filter.append(data[i])
                }
            }
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let menu = UIMenu(title: "", children: [all, smalltalk, til, cat, qna])
        menuButton.menu = menu
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
        let delete = UIAction(title: "게시물 삭제", handler: { _ in
            data.remove(at: indexlist[indexPath.row])
            filter.remove(at: indexPath.row)
            indexlist.remove(at: indexPath.row)
            self.mainTableView.reloadSections(IndexSet(0...0), with: .automatic)
        })
        let menu = UIMenu(title: "", children: [delete])
        cell.cellSettingButton.menu = menu
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
        selectedIndex = indexPath.row
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

