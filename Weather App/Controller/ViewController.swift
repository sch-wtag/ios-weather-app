//
//  ViewController.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import UIKit

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Constants.splashAnimationTime
        ) {
            self.navigateToHomeScreen()
        }
    }
    
    private func navigateToHomeScreen() {
        let storyBoard = UIStoryboard(name: StringConstants.mainStoryBoard, bundle: nil)
        if let viewController = storyBoard.instantiateViewController(withIdentifier: StringConstants.homeViewController) as? HomeViewController {
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
}
