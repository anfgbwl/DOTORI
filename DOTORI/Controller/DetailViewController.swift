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
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dequeuedCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell {
            let posting = filter[selectedIndex]
            dequeuedCell.collectionImageView.image = posting.contentImage
            return dequeuedCell
        }
        else{
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter[selectedIndex].reply.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("daadasdas")
        if let dequeuedCell = replyTableView.dequeueReusableCell(withIdentifier: "posingTableViewCell") as? PostingTableViewCell {
            if selectedIndex < filter.count && indexPath.row < filter[selectedIndex].reply.count {
                let cell = filter[selectedIndex].reply[indexPath.row]
                dequeuedCell.nameLabel.text = cell.user.name
                dequeuedCell.nicknameLabel.text = cell.user.nickname
                if cell.createTime == cell.updateTime
                {
                    dequeuedCell.createdLabel.text = cell.createTime.GetCurrentTime(format : "yyyy-MM-dd HH:mm:ss")
                }else{
                    dequeuedCell.createdLabel.text = cell.updateTime.GetCurrentTime(format :  "yyyy-MM-dd HH:mm:ss")
                }
                dequeuedCell.profileImageView.image = cell.user.profileImage
                dequeuedCell.contentTextView.text = cell.content
            }
            
            dequeuedCell.modifyButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
                let modifyReplyController = storyboard.instantiateViewController(withIdentifier: "modifyReplyController") as! ModifyReplyController
                
                if let presentationController = modifyReplyController.presentationController as? UISheetPresentationController {
                    presentationController.detents = [
                        .medium(),
                    ]
                    presentationController.prefersGrabberVisible = true
                    presentationController.delegate = self
                }
                
                modifyReplyController.content = dequeuedCell.contentTextView.text
                modifyReplyController.selectedModifyCellIndex = indexPath.row
                modifyReplyController.largetitle = "수정"
                modifyReplyController.modifyTextDelegate = self
                replyTableView.resignFirstResponder()
                self.present(modifyReplyController, animated: true)
            }
            
            dequeuedCell.deleteButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                let alertController = UIAlertController(title: "경고", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) {  _ in
                    let index = indexPath.row
                    filter[self.selectedIndex].reply.remove(at: index)
                    self.replyTableView.reloadData()
                }
                alertController.addAction(confirmAction)
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
                
            }
            dequeuedCell.profileButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                let storyboard = UIStoryboard(name: "MyPageViewController", bundle: nil)
                let myPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                
                if let text = dequeuedCell.nameLabel.text {
                    myPageVC.selectedUserName = text
                }
                self.present(myPageVC, animated: true)
            }
            return dequeuedCell
            
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension DetailViewController : UITextViewDelegate, UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let modifyReplyController = storyboard.instantiateViewController(withIdentifier: "modifyReplyController") as! ModifyReplyController
        
        if let presentationController = modifyReplyController.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .large(),
            ]
            presentationController.prefersGrabberVisible = true
            presentationController.delegate = self
        }
        
        modifyReplyController.content = ""
        modifyReplyController.largetitle = "댓글 추가"
        modifyReplyController.modifyTextDelegate = self
        replyInputTextField.resignFirstResponder()
        self.present(modifyReplyController, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

class DetailViewController: UIViewController,ModifyTextDelegate {
    
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
    @IBOutlet weak var replyInputTextField: UITextField! //댓글 입력 키보드 텍스트필드
    var isBookFilled = false
    var selectedIndex = 0
    var selectedModifyCellIndex = 0
    var contentImageView : UIImage?
    var nameLabelText : String?
    
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
        
        
        //처음 프로필 설정하는부분..
        let user = filter[selectedIndex].user
        let posting = filter[selectedIndex]
        profileImageView.image = user.profileImage
        nameLabel.text = user.name
        nicknameLabel.text = user.nickname
        createdLabel.text = posting.createTime.GetCurrentTime(format: "yyyy-MM-dd HH:mm:ss")
        textView.text = posting.content
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        //처음 보여지는 부분..
        isBookFilled = filter[selectedIndex].bookmark
        if !isBookFilled
        {
            bookmarkImageView.image = UIImage(systemName: "bookmark")
        }else{
            bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
        }
    }
    
    func didTextUpdated(updateTime: Date, content: String, index: Int) {
        filter[self.selectedIndex].reply[index].content = content
        filter[self.selectedIndex].reply[index].updateTime = updateTime
        self.replyTableView.reloadData()
    }
    func didTextCreated(createTime: Date, content: String) {
        let additionalReplyInfo = ReplyInfo(user: user5, content:content, createTime: createTime, updateTime: Date())
        filter[selectedIndex].reply.append(additionalReplyInfo)
        replyInputTextField.resignFirstResponder()
        replyTableView.reloadData()
    }
    
    func addTapGestureToImageView(_ imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            if imageView == shareImageView {
                let textToShare = "공유"
                let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = imageView
                activityViewController.popoverPresentationController?.sourceRect = imageView.bounds
                present(activityViewController, animated: true, completion: nil)
            } else if imageView == bookmarkImageView {
                isBookFilled = !isBookFilled
                filter[selectedIndex].bookmark = isBookFilled
                if !isBookFilled
                {
                    bookmarkImageView.image = UIImage(systemName: "bookmark")
                }else{
                    bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
                }
            }else{
                let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
                let modifyReplyController = storyboard.instantiateViewController(withIdentifier: "modifyReplyController") as! ModifyReplyController
                if let presentationController = modifyReplyController.presentationController as? UISheetPresentationController {
                    presentationController.detents = [
                        .large(),
                    ]
                    presentationController.prefersGrabberVisible = true
                    presentationController.delegate = self
                }
                
                modifyReplyController.content = ""
                modifyReplyController.largetitle = "댓글 추가"
                modifyReplyController.modifyTextDelegate = self
                present(modifyReplyController, animated: true, completion: nil)
            }
        }
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
    
    var modifyButtonAction: (() -> Void)?
    var deleteButtonAction: (() -> Void)?
    var profileButtonAction : (() ->Void)?
    
    override func awakeFromNib() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        
        super.awakeFromNib()
        let menu = UIMenu(title: "", children: [
            UIAction(title: "수정", handler: { _ in
                self.modifyButtonAction?()
            }),
            UIAction(title: "삭제", handler: { _ in
                self.deleteButtonAction?()
            }),
        ])
        modifyOrDelteButton.showsMenuAsPrimaryAction = true
        modifyOrDelteButton.menu = menu
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func profileImageTapped() {
        self.profileButtonAction?()
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

protocol ModifyTextDelegate : AnyObject{
    func didTextUpdated( updateTime : Date,  content : String,  index : Int)
    func didTextCreated( createTime : Date,  content : String)
}



class ModifyReplyController : UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    var  largetitle : String?
    var  content : String?
    var  selectedModifyCellIndex : Int?
    weak var modifyTextDelegate : ModifyTextDelegate?
    @IBAction func oncompletePressed(_ sender: Any) {
        let contentText = contentTextView.text
        if largetitle!.contains("수정")
        {
            if let text = contentText, let index = selectedModifyCellIndex
            {
                modifyTextDelegate?.didTextUpdated(updateTime: Date(), content: text, index: index)
            }
        }else{
            if let text = contentText{
                modifyTextDelegate?.didTextCreated(createTime: Date(), content: text)
            }
        }
        contentTextView.resignFirstResponder()
        self.dismiss(animated: true)
    }
    @IBAction func onbackPressed(_ sender: Any) {
        contentTextView.resignFirstResponder()
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = content{
            contentTextView.text = text
        }
        if let index = selectedModifyCellIndex
        {
            selectedModifyCellIndex = index
        }
        if let title = largetitle{
            titleLabel.text = title
            if title.contains("댓글 추가"){
                contentTextView.becomeFirstResponder()
            }
        }
        if let presentationController = self.presentationController as? UISheetPresentationController {
            presentationController.delegate = self
        }
        contentTextView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let newSheetHeight = view.frame.height - keyboardFrame.height
            preferredContentSize = CGSize(width: preferredContentSize.width, height: newSheetHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        preferredContentSize = CGSize(width: preferredContentSize.width, height: 700) // 여기에 적절한 높이 값 넣기
    }
}
extension ModifyReplyController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}

extension DetailViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}
