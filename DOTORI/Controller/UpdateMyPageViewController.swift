//
//  UpdateMyPageViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit
import Photos
import PhotosUI

class UpdateMyPageViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var updateCancelButton: UIButton!
    @IBOutlet weak var updateCompleteButton: UIButton!
    @IBOutlet weak var updateImageView: UIImageView!
    @IBOutlet weak var updateUrlTextField: UITextField!
    @IBOutlet weak var updateNameTextField: UITextField!
    @IBOutlet weak var updateTextView: UITextView!
    @IBOutlet weak var updateImageButton: UIButton!
    
    var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateTextView.delegate = self
    }
    
    func configureUI() {
        updateImageView.layer.cornerRadius = updateImageView.frame.size.width / 2
        updateImageView.clipsToBounds = true
//        updateImageView.isUserInteractionEnabled = true
        
        updateTextView.layer.borderWidth = 2.0
        updateTextView.layer.borderColor = UIColor.black.cgColor
        updateTextView.layer.cornerRadius = 8.0
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "이곳은 자기소개를 적는 공간입니다."
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        
        updateTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: updateTextView.font!.pointSize / 2)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        print("눌림")
        
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    let scaledImage = self.scaleImage(image, toSize: self.updateImageView.frame.size)
                    self.updateImageView.layer.cornerRadius = self.updateImageView.frame.size.width / 2
                    self.updateImageView.clipsToBounds = true
                    self.updateImageView.image = scaledImage
                }
            }
        }
    }

    func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? image
    }
}

extension UpdateMyPageViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
