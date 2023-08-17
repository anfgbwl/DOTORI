//
//  ViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //더미데이터들

    }
    var selectedIndex : Int?
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }
        cell.posting_content.text = data[indexPath.row].content
        cell.posting_contentimage.image = data[indexPath.row].contentImage
        cell.posting_time.text = data[indexPath.row].createTime.GetCurrentTime(format: "yyyy-MM-dd")
        cell.profile_image.image = data[indexPath.row].user.profileImage
        cell.profile_nickname.text = data[indexPath.row].user.nickname
        return cell
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

