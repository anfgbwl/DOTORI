//
//  BookmarkViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class BookmarkViewController: UIViewController {
    @IBOutlet weak var bookmarkView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        filter = []
        for i in 0..<data.count {
            if data[i].bookmark == true {
                filter.append(data[i])
            }
        }
        bookmarkView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    
}
