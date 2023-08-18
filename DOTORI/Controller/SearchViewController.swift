//
//  SearchViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

// class SearchTableViewCell:

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        searchTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.addTarget(self, action: #selector(TextChange), for: .editingChanged)
        searchBar.searchTextField.placeholder = "검색어를 입력해주세요"
    }
    @objc func TextChange(_ sender : UISearchTextField) {
        search = []
        searchindex = []
        for i in 0..<data.count {
            if data[i].content.contains(sender.text!) || data[i].user.name.contains(sender.text!) {
                search.append(data[i])
                searchindex.append(i)
            }
        }
        searchTableView.reloadData()
    }
    var selectedIndex : Int?
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }
        let posting = search[indexPath.row]
        cell.setupUI(posting: posting)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkChange), for: .touchUpInside)
        cell.bookmarkButton.tag = indexPath.row
        return cell
    }
    @objc func bookmarkChange (_ sender : UIButton){
        self.searchTableView.reloadData()
        if search[sender.tag].bookmark == true {
            search[sender.tag].bookmark = false
        }
        else {
            search[sender.tag].bookmark = true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = searchindex[indexPath.row]
        performSegue(withIdentifier: "SearchToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.selectedIndex = selectedIndex!
            }
        }
    }
}
