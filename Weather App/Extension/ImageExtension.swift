//
//  ImageExtension.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/29/24.
//

import Foundation
import UIKit

extension UIImageView {
    func loadNetworkImage(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
