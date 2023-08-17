//
//  CustomTableViewCell.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var profile_name: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_nickname: UILabel!
    @IBOutlet weak var posting_time: UILabel!
    @IBOutlet weak var posting_contentimage: UIImageView!
    @IBOutlet weak var posting_content: UITextView!
    func setupUI(posting: PostingInfo) {
        profile_image.image = posting.user.profileImage ?? UIImage(named: "defaultProfileImage")
        profile_image.layer.cornerRadius = profile_image.frame.size.width / 2
        profile_image.clipsToBounds = true
        profile_name.text = posting.user.name
        profile_nickname.text = posting.user.nickname
        posting_time.text = posting.createTime.GetCurrentTime(format: "YYYY-MM-dd")
        posting_content.text = posting.content
        posting_contentimage.image = posting.contentImage ?? UIImage(named: "defaultProfileImage")
        posting_contentimage.layer.cornerRadius = 10
        posting_contentimage.clipsToBounds = true

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        posting_content.delegate = self
        posting_content.isScrollEnabled = false
        posting_content.sizeToFit()
    }
}
