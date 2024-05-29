//
//  InformationTableViewCell.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/28/24.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    
    static let cellName = "InformationTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: cellName, bundle: nil)
    }
    
    @IBOutlet private weak var airSpeed: UILabel!
    @IBOutlet private weak var airPressure: UILabel!
    @IBOutlet private weak var humidity: UILabel!
    @IBOutlet private weak var seaLevel: UILabel!
    @IBOutlet private weak var groundLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.backgroundColor = .init(red: 0.20, green: 0.30, blue: 0.39, alpha: 1.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func updateData(
        airSpeed: String,
        airPressure: String,
        humidity: String,
        sunrise: String,
        sunset: String
    ) {
        self.airSpeed.text = "\(airSpeed) (Air speed)"
        self.airPressure.text = "\(airPressure) (Air pressure)"
        self.humidity.text = "\(humidity) (Humidity)"
        self.seaLevel.text = "\(sunrise) (sunrise)"
        self.groundLevel.text = "\(sunset) (sunset)"
    }
}
