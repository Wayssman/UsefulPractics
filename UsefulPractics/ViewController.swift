//
//  ViewController.swift
//  UsefulPractics
//
//  Created by Alexandr on 25.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @UserDefaultsStorage(key: "aa", defaultValue: 14)
    var test: Int
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        print(test)
        test = 18
        print(test)
    }
}

