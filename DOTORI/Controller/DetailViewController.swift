//
//  DetailViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 2
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dequeuedCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell {
           // dequeuedCell.collectionImageView.image = UIImage(named: "image1")?.resized(toWidth: 120, toHeight: 70)
            dequeuedCell.collectionImageView.image = UIImage(named: "image1")?.resized(toWidth: 200, toHeight: 70)
            return dequeuedCell
        }
        else{
            return UICollectionViewCell()
        }
    }
}



extension DetailViewController :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dequeuedCell = replyTableView.dequeueReusableCell(withIdentifier: "posingTableViewCell") as? PostingTableViewCell {
            dequeuedCell.nameLabel.text = "계정이름임"
            dequeuedCell.nicknameLabel.text = "닉네임임"
            dequeuedCell.createdLabel.text = Date().GetCurrentTime()
            dequeuedCell.profileImageView.image = UIImage(systemName: "square.and.arrow.up.circle")
            dequeuedCell.modifyOrDelteButton.setTitle("...", for: .normal)
            return dequeuedCell
            
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//extension DetailViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //let addtionalHeight = textView.contentSize.height
//        return CGSize(width: 160, height: 130)
//        //return CGSize(width: 160, height: 120 - addtionalHeight + 5)
//    }
//}


class DetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var nameLabel: UILabel! //이름
    @IBOutlet weak var nicknameLabel: UILabel! // 닉네임
    @IBOutlet weak var profileImageView: UIImageView! // 계정 사진
    
    @IBOutlet weak var imageCollectionView: UICollectionView! // 이미지 첨부 화면
    @IBOutlet weak var textView: UITextView! // 컨텐츠
    
    @IBOutlet weak var createdLabel: UILabel! // 생성시간
    @IBOutlet weak var replyImageView: UIImageView! // 댓글버튼
    
    @IBOutlet weak var bookmarkImageView: UIImageView! // 북마크버튼
    @IBOutlet weak var shareImageView: UIImageView! //공유버튼
    
    @IBOutlet weak var replyTableView: UITableView! // 맨밑 테이블뷰
    
    @IBOutlet weak var replyInputTextField: UITextField!
    var isBookFilled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        replyTableView.register(PostingTableViewCell.self, forCellReuseIdentifier: "PosingTableViewCell")
        replyTableView.dataSource = self
        replyTableView.delegate = self
        
        addTapGestureToImageView(shareImageView)
        addTapGestureToImageView(bookmarkImageView)
        addTapGestureToImageView(replyImageView)
        
        replyInputTextField.delegate = self
        
        textView.translatesAutoresizingMaskIntoConstraints = true
        
        
    }
    
    func addTapGestureToImageView(_ imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            if imageView == shareImageView {
                print("shareImageView Tapped")
                let textToShare = "공유"
                let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
                
                activityViewController.popoverPresentationController?.sourceView = imageView
                activityViewController.popoverPresentationController?.sourceRect = imageView.bounds
                present(activityViewController, animated: true, completion: nil)
            } else if imageView == bookmarkImageView {
                isBookFilled = !isBookFilled
                if !isBookFilled
                {
                    bookmarkImageView.image = UIImage(systemName:  "book")
                }else{
                    bookmarkImageView.image = UIImage(systemName: "book.fill")
                }
            }else{
                replyInputTextField.becomeFirstResponder()
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textColor = .black
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        replyInputTextField.resignFirstResponder()
        return true
    }
}

class DetailCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var collectionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
}


class PostingTableViewCell : UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var modifyOrDelteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: "수정", handler: { _ in
                print("수정 로직 필요")
            }),
            UIAction(title: "삭제", handler: { _ in
                print("삭제 로직 필요")
            }),
        ])
        modifyOrDelteButton.showsMenuAsPrimaryAction = true
        modifyOrDelteButton.menu = menu
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat, toHeight height : CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: height)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
}
