//
//  SearchViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

// class SearchTableViewCell:

class SearchViewController: UIViewController {
    
    @IBOutlet weak var serachTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.addTarget(self, action: #selector(TextChange), for: .editingChanged)
    }
    @objc func TextChange(_ sender : UISearchTextField) {
        search = []
        for i in 0..<data.count {
            if data[i].content.contains(sender.text!){
                search.append(data[i])
            }
        }
        serachTableView.reloadData()
    }
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
            return cell
    }
}
