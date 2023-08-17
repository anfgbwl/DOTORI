//
//  CustomTableViewCell.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_nickname: UILabel!
    @IBOutlet weak var posting_time: UILabel!
    @IBOutlet weak var posting_content: UILabel!
    @IBOutlet weak var posting_contentimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
