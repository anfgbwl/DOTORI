//
//  UIAlertController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            //추가 작업
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
