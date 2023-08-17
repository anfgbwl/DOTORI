//
//  CreateViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//
import UIKit
import PhotosUI

class CreateViewController: UIViewController, UICollectionViewDelegateFlowLayout, PHPickerViewControllerDelegate {
    
    var selectedImages: [UIImage] = []
    var selectedCategory: String = ""
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popUpButton: UIButton!
    
    @IBAction func deleteImageButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? CreateCollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            selectedImages.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    @IBAction func backHomeButtonTapped(_ sender: UIButton) {
        // 글 작성 취소 alert
        let alertController = UIAlertController(title: "글 작성 취소", message: "게시글 작성을 취소하시겠습니까?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            
            // 메인화면으로 이동
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        let newPosting = PostingInfo(
            user: user5,
            category: selectedCategory,
            content: textView.text,
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
        let alertController = UIAlertController(title: "글 작성 완료", message: "새 게시글이 작성되었습니다.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
            }
        }))
        
        present(alertController, animated: true, completion: nil)
        initAll()
        print("새 글 테스트: \(newPosting.category), \(newPosting.content), \(newPosting.contentImage)")
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
        textView.text = "여기를 탭하여 입력을 시작하세요."
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
                        let scaledImage = self?.scaleImage(image, toSize: CGSize(width: 200, height: 200)) ?? image
                        
                        DispatchQueue.main.async {
                            self?.selectedImages.append(scaledImage)
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
        textView.text = "여기를 탭하여 입력을 시작하세요."
        textView.textColor = UIColor.lightGray
        selectedImages.removeAll()
        collectionView.reloadData()
    }
}

extension CreateViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // 콜렉션뷰의 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    // 콜렉션뷰의 셀 내용 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateCollectionViewCell", for: indexPath) as! CreateCollectionViewCell
        cell.selectedImg.image = selectedImages[indexPath.item]
        return cell
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "여기를 탭하여 입력을 시작하세요."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
