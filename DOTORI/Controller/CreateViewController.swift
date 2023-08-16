//
//  CreateViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//
import UIKit
import PhotosUI

class CreateViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PHPickerViewControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func deleteImageButtonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? CreateCollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
                selectedImages.remove(at: indexPath.item)
                collectionView.deleteItems(at: [indexPath])
            }
    }
    
    var selectedImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        textView.delegate = self
        textView.text = "여기를 탭하여 입력을 시작하세요."
        textView.textColor = UIColor.lightGray
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

    // UICollectionViewDataSource 및 UICollectionViewDelegate 메서드 구현
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
    
    // 이미지를 표시할 콜렉션뷰 셀의 클래스
    class ImageCell: UICollectionViewCell {
        @IBOutlet weak var imageView: UIImageView!
    }
    
    func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? image
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
