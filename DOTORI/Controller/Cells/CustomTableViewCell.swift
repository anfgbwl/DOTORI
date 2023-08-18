//
//  CustomTableViewCell.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/16.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var cellSettingButton: UIButton!
    @IBOutlet weak var profile_name: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_nickname: UILabel!
    @IBOutlet weak var posting_time: UILabel!
    @IBOutlet weak var posting_contentimage: UIImageView!
    @IBOutlet weak var posting_content: UITextView!
    @IBOutlet weak var bookmarkButton: UIButton!
    func setupUI(posting: PostingInfo) {
        profile_image.image = posting.user.profileImage
        profile_image.layer.cornerRadius = profile_image.frame.size.width / 2
        profile_image.clipsToBounds = true
        profile_name.text = posting.user.name
        profile_nickname.text = posting.user.nickname
        posting_time.text = posting.createTime.GetCurrentTime(format: "YYYY-MM-dd")
        posting_content.text = posting.content
        posting_content.textContainerInset = UIEdgeInsets.zero
        posting_content.textContainer.lineFragmentPadding = 0
        posting_contentimage.image = posting.contentImage
        posting_contentimage.layer.cornerRadius = 10
        posting_contentimage.clipsToBounds = true
        if posting.bookmark == true {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        else{
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)        }

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
