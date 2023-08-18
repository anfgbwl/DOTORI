//
//  MyPostingTableViewCell.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/17.
//

import Foundation
import UIKit

class MyPostingTableViewCell: UITableViewCell, UITextViewDelegate {
    var shareButtonTapped: (() -> Void)?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var postingSetting: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var replyCount: UILabel!
    
    @IBAction func shareButton(_ sender: Any) {
        shareButtonTapped?()
    }
    
    func setupUI(posting: PostingInfo) {
        replyCount.text = String(posting.reply.count)
        profileImage.image = posting.user.profileImage ?? UIImage(named: "defaultProfileImage")
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        name.text = posting.user.name
        nickname.text = posting.user.nickname
        createTime.text = posting.createTime.GetCurrentTime(format: "YYYY-MM-dd")
        content.text = posting.content
        content.textContainerInset = UIEdgeInsets.zero
        content.textContainer.lineFragmentPadding = 0
        contentImage.image = posting.contentImage ?? nil
        contentImage.layer.cornerRadius = 10
        contentImage.clipsToBounds = true
        if posting.bookmark == true {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        content.isScrollEnabled = false
        content.sizeToFit()
    }
    
}
