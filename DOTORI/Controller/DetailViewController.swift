//
//  DetailViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

enum UISheepPaperType {
    case create
    case update
    
    var typeValue: String {
        switch self {
        case .create: return "댓글 추가"
        case .update: return "댓글 수정"
        }
    }
}

class DetailViewController: UIViewController,ModifyTextDelegate {
    
    //상단
    @IBOutlet weak var nameLabel: UILabel! //이름
    @IBOutlet weak var nicknameLabel: UILabel! // 닉네임
    @IBOutlet weak var profileImageView: UIImageView! // 계정 사진
    //중단
    @IBOutlet weak var imageCollectionView: UICollectionView! // 이미지 첨부 화면
    @IBOutlet weak var textView: UITextView! // 컨텐츠
    @IBOutlet weak var createdLabel: UILabel! // 생성시간
    @IBOutlet weak var replyImageView: UIImageView! // 댓글버튼
    @IBOutlet weak var bookmarkImageView: UIImageView! // 북마크버튼
    @IBOutlet weak var shareImageView: UIImageView! //공유버튼
    //하단
    @IBOutlet weak var replyTableView: UITableView! // 맨밑 테이블뷰
    @IBOutlet weak var replyInputTextField: UITextField! //댓글 입력 키보드 텍스트필드
    
    @IBOutlet weak var contentImageView: UIImageView!
    var isBookFilled = false
    var selectedIndex = 0 //메인화면에서 넘겨주는 셀 인덱스
    var selectedModifyCellIndex = 0 //댓글에서 프로필 클릭시 프로필 정보의 셀 인덱스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isBookFilled = filter[selectedIndex].bookmark
        loadUserProfileInfo()
        setUIEvents()
        setBookmarkFillInfo()
        setUIConfig()
        
        let posting = filter[selectedIndex]
        if let image = posting.contentImage{
            contentImageView.image =  posting.contentImage
          
        }else{
            contentImageView.isHidden = true
            contentImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
    }
    func setUIEvents(){
        replyTableView.register(PostingTableViewCell.self, forCellReuseIdentifier: "PosingTableViewCell")
        replyTableView.dataSource = self
        replyTableView.delegate = self
        
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.sizeToFit() // 초기 크기 조정
        
        
        addTapGestureToImageView(shareImageView)
        addTapGestureToImageView(bookmarkImageView)
        addTapGestureToImageView(replyImageView)
        
        replyInputTextField.delegate = self
        
    }
    func setUIConfig(){
        profileImageView.setImageRoundRadius()
        
        contentImageView.layer.cornerRadius = 10
        contentImageView.clipsToBounds = true
    }
    
    func loadUserProfileInfo(){
        let user = data[selectedIndex].user
        let posting = data[selectedIndex]
        profileImageView.image = user.profileImage
        nameLabel.text = user.name
        nicknameLabel.text = user.nickname
        createdLabel.text = posting.createTime.GetCurrentTime(format: "yyyy-MM-dd HH:mm:ss")
        textView.text = posting.content
    }
    func setBookmarkFillInfo(){
        if !isBookFilled
        {
            bookmarkImageView.image = UIImage(systemName: "bookmark")
        }else{
            bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
        }
    }
    
    func createNextPresentationController(nextVCType : UISheepPaperType, content : String, selectedCellIndex : Int = 0){
        let modifyReplyController = self.storyboard?.instantiateViewController(withIdentifier: "modifyReplyController") as! ModifyReplyController
        if let presentationController = modifyReplyController.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
            ]
            presentationController.prefersGrabberVisible = true
        }
        if nextVCType == .update
        {
            modifyReplyController.selectedModifyCellIndex = selectedCellIndex
        }
        modifyReplyController.largetitle = nextVCType.typeValue
        modifyReplyController.content = content
        modifyReplyController.modifyTextDelegate = self
        replyInputTextField.resignFirstResponder()
        self.present(modifyReplyController, animated: true)
    }
    
    func didTextUpdated(updateTime: Date, content: String, index: Int) {
        data[self.selectedIndex].reply[index].content = content
        data[self.selectedIndex].reply[index].updateTime = updateTime
        replyTableView.reloadData()
    }
    func didTextCreated(createTime: Date, content: String) {
        let additionalReplyInfo = ReplyInfo(user: user5, content:content, createTime: createTime, updateTime: Date())
        data[selectedIndex].reply.append(additionalReplyInfo)
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
                setBookmarkFillInfo()
                data[selectedIndex].bookmark = isBookFilled
                
            }else{
                createNextPresentationController(nextVCType: .create, content : "")
            }
        }
    }
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dequeuedCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell {
            let posting = data[selectedIndex]
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
        return data[selectedIndex].reply.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dequeuedCell = replyTableView.dequeueReusableCell(withIdentifier: "posingTableViewCell") as? PostingTableViewCell {
            if selectedIndex < data.count && indexPath.row < data[selectedIndex].reply.count {
                let cell = data[selectedIndex].reply[indexPath.row]
                dequeuedCell.createdLabel.text = cell.updateTime.GetCurrentTime(format :  "yyyy-MM-dd HH:mm:ss") // 차후 업데이트시 "몇분전, 1일전 이런식으로 할지 수정"
                dequeuedCell.nameLabel.text = cell.user.name
                dequeuedCell.nicknameLabel.text = cell.user.nickname
                dequeuedCell.profileImageView.image = cell.user.profileImage
                dequeuedCell.contentTextView.text = cell.content
            }
            dequeuedCell.modifyButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                createNextPresentationController(nextVCType: .update, content : dequeuedCell.contentTextView.text, selectedCellIndex: indexPath.row)
            }
            dequeuedCell.deleteButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                let alertController = UIAlertController(title: "경고", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) {  _ in
                    let index = indexPath.row
                    data[self.selectedIndex].reply.remove(at: index)
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
}
extension DetailViewController : UITextViewDelegate, UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        createNextPresentationController(nextVCType: .create, content: "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

class DetailCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var collectionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
        profileImageView.setImageRoundRadius()
        contentTextView.sizeToFit()
        contentTextView.isScrollEnabled = false
    }
    
    @objc func profileImageTapped() {
        self.profileButtonAction?()
    }
}
extension UIImageView{
    func setImageRoundRadius(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
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
        if largetitle!.contains("댓글 수정")
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
        }
        contentTextView.delegate = self
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
