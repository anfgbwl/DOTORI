//
//  CreateViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//
import UIKit
import PhotosUI

class CreateViewController: UIViewController, UICollectionViewDelegateFlowLayout, PHPickerViewControllerDelegate {
    
    var selectedImages: [UIImage] = []   // data에 insert할 원본 이미지
    var resizedImaged: [UIImage] = []    // 해당 VC 내에서 보여줄 리사이즈된 이미지
    var selectedCategory: String = "TIL" // default selection
    var placeholder: String = "여기를 탭하여 입력을 시작하세요."
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popUpButton: UIButton!
    
    @IBAction func deleteImageButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? CreateCollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            resizedImaged.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    @IBAction func backHomeButtonTapped(_ sender: UIButton) {
        // 글 작성 취소 alert
        let alertController = UIAlertController(title: "", message: "작성을 취소하시겠습니까?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "유지", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "작성 취소", style: .destructive, handler: { _ in
            // 메인화면으로 이동
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        var textViewContent = textView.text
        
        if textViewContent == placeholder {
            // 입력이 없을 경우 글 생성하지 않고 alert
            let alertController = UIAlertController(title: "", message: "내용을 입력해주세요.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return // 게시글을 생성하지 않고 종료
        }
        
        let newPosting = PostingInfo(
            user: loginUser,
            category: selectedCategory,
            content: textViewContent ?? "",
            createTime: Date(),
            updateTime: Date(),
            contentImage: selectedImages.first,
            bookmark: false,
            bookmarkCount: 0,
            reply: [],
            tilUrl: ""
        )
        
        // 생성한 PostingInfo 객체 데이터에 추가
        data.insert(newPosting, at: 0)
        
        // 포스트 완료 alert
        let alertController = UIAlertController(title: "", message: "게시글이 작성되었습니다.", preferredStyle: .alert)
                
        present(alertController, animated: true, completion: nil)

        // 1초 후에 홈화면으로 이동
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.tabBarController?.selectedIndex = 0
            alertController.dismiss(animated: true, completion: nil)
        }
        
        initAll()
        // print("새 글 테스트: \(newPosting.category), \(newPosting.content), \(newPosting.contentImage)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        configTextView()
        configPopUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initAll()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configTextView() {
        textView.delegate = self
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
    }
    
    private func configPopUpButton() {
        let popUpButtonClosure = { (action: UIAction) in
            self.selectedCategory = action.title // 선택된 카테고리 저장
            print("Selected menu: \(action.title)")
        }
        
        popUpButton.menu = UIMenu(title: "카테고리", children: [
            UIAction(title: "TIL", handler: popUpButtonClosure),
            UIAction(title: "잡담", handler: popUpButtonClosure),
            UIAction(title: "질문", handler: popUpButtonClosure),
            UIAction(title: "고양이방", handler: popUpButtonClosure),
        ])
        popUpButton.showsMenuAsPrimaryAction = true
    }
    
    // 이미지 선택 버튼을 눌렀을 때 호출되는 액션
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0 // 0은 제한 없음을 의미
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // 이미지 선택 완료 후 호출되는 delegate 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    if let image = image as? UIImage {
                        // 이미지 크기를 조절하여 새로운 크기로 변환
                        let scaledImage = self?.scaleImage(image, toSize: CGSize(width: 300, height: 300)) ?? image
                        
                        DispatchQueue.main.async {
                            self?.resizedImaged.append(scaledImage)
                            self?.selectedImages.append(image) // 원본 이미지 데이터
                            self?.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    // 이미지 리사이즈 함수
    private func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? image
    }
    
    private func initAll() {
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        resizedImaged.removeAll()
        collectionView.reloadData()
    }
}

extension CreateViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // 콜렉션뷰의 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resizedImaged.count
    }
    
    // 콜렉션뷰의 셀 내용 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateCollectionViewCell", for: indexPath) as! CreateCollectionViewCell
        cell.selectedImg.image = resizedImaged[indexPath.item]
        return cell
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            if self.traitCollection.userInterfaceStyle == .dark {
                textView.textColor = UIColor.white
            } else {
                textView.textColor = UIColor.black
            }
        }
    }
}
