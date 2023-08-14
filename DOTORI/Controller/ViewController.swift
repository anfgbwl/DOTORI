//
//  ViewController.swift
//  DOTORI
//
//  Created by 도토리묵 on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    @IBAction func btn(_ sender: Any) {
        performSegue(withIdentifier: "mainToSearch", sender: self)
    }
    
}

