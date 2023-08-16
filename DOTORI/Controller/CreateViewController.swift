//
//  CreateViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit
import Photos
import PhotosUI

//class PostingInfo {
//    var category : String = ""
//    var content : String =  ""
//    var createTime : Date = Date()
//    var updateTime : Date = Date()
//    var contentImage : String = ""
//    var bookmark : Bool = false
//    var bookmarkCount : Int = 0
//    var reply : [ReplyInfo] = []
//    var tilUrl : String = ""
//}

class cell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

class CreateViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDataSource {

    @IBOutlet weak var selectedImagesView: UIView!
    @IBAction func createButton(_ sender: Any) {}
    @IBOutlet weak var textView: UITextView!
    @IBAction func addImages(_ sender: UIButton) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 3
        config.filter = .images
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
        print("click")
    }
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 150, height: 150)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        c.register(cell.self, forCellWithReuseIdentifier: "cell")
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        selectedImagesView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        
        // title = "이미지 추가"
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        textView.delegate = self
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        textView.text = "여기를 탭하여 입력을 시작하세요."
        textView.textColor = UIColor.lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }
//
//    @objc private func didTapAdd() {
//        var config = PHPickerConfiguration(photoLibrary: .shared())
//        config.selectionLimit = 3
//        config.filter = .images
//
//        let vc = PHPickerViewController(configuration: config)
//        vc.delegate = self
//        present(vc, animated: true)
//    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        let group = DispatchGroup()
        
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                defer {
                    group.leave()
                }
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                group.notify(queue: .main) {
                    print("test: \(image)")
                    self?.collectionView.reloadData()
                }
            }
        }
        
        collectionView.reloadData()
    }
    
    private var images = [UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? cell else { fatalError() }
        
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text =  "여기를 탭하여 입력을 시작하세요."
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
