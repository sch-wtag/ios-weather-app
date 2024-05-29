//
//  TemperatureTableViewCell.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/28/24.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    
    static let cellName = "TemperatureTableViewCell"
    
    @IBOutlet private weak var coordinates: UILabel!
    @IBOutlet private weak var location: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var feelsLikeTemp: UILabel!
    @IBOutlet private weak var minMaxTemp: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: cellName, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func bindData(
        coordinates: String,
        location: String,
        image: String,
        description: String,
        temperature: String,
        feelsLikeTemp: String,
        minTemp: String,
        maxTemp: String
    ) {
        self.coordinates?.text = coordinates
        self.location?.text = location
        self.iconImage?.loadNetworkImage(url: image)
        self.weatherDescription.text = description
        self.temperature?.text = temperature
        self.feelsLikeTemp?.text = "feels like \(feelsLikeTemp)"
        self.minMaxTemp?.text = "Min \(minTemp), Max \(maxTemp)"
    }
}
