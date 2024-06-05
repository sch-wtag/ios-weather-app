//
//  ViewController.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIndicatorStyle()
        
        accessLocation()
    }
    
    private func setIndicatorStyle() {
        indicator.color = .white
        indicator.style = .medium
        indicator.startAnimating()
    }
    
    private func accessLocation() {
        LocationManager.instance.accessCurrentLocation { lat, long in
            UserDefaults.standard.setValue(lat, forKey: StringConstants.locationLatitude)
            UserDefaults.standard.setValue(long, forKey: StringConstants.locationLongitude)
            UserDefaults.standard.synchronize()
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Constants.splashAnimationTime
            ) {
                self.indicator.stopAnimating()
                self.navigateToHomeScreen()
            }
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
