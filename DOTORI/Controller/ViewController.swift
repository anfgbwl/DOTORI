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
        data[0].user.nickname = "im_pigeon"
        data[0].content = "9999999999999999999999999999999"
        data[0].user.profileImage = UIImage(named: "pigeon.png")
        data[0].contentImage = UIImage(named: "pigeon.png")
        data[1].user.nickname = "im_lion"
        data[1].user.profileImage = UIImage(named: "pigeon.png")
        data[1].content = "어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥어흥"
        data[1].contentImage = UIImage(named: "lion.jpeg")
        data[2].user.nickname = "DotoriMook"
        data[2].user.profileImage = UIImage(named: "dotori.png")
        data[2].content = "나는 도토리다"
        data[2].contentImage = UIImage(named: "dotori.png")
    }

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
        cell.posting_time.text = data[indexPath.row].createTime.GetCurrentTime()
        cell.profile_image.image = data[indexPath.row].user.profileImage
        cell.profile_nickname.text = data[indexPath.row].user.nickname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 선택시 함수
        performSegue(withIdentifier: "HomeToDetail", sender: self)
    }
}

