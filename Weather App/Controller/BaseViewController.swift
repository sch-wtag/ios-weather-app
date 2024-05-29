//
//  BaseViewController.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UILabel.appearance().textColor = .white
        
        view.backgroundColor = .init(hex: "#577B8D")
    }
}
