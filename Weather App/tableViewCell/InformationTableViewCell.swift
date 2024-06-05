//
//  InformationTableViewCell.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/28/24.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    
    static let cellName = "InformationTableViewCell"
    
    var viewModel: InformationTableViewCellViewModel? {
        didSet {
            self.updateCellUI()
        }
    }
    
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
    
    public func updateCellUI() {
        let result = viewModel?.weatherData
        
        self.airSpeed.text = "\(result?.wind?.speed ?? 0) (Air speed)"
        self.airPressure.text = "\(result?.main?.pressure ?? 0) (Air pressure)"
        self.humidity.text = "\(result?.main?.humidity ?? 0) (Humidity)"
        self.seaLevel.text = "\(DateTimeHelper.convertToDateTimeFromTimeStamp(timeStamp: result?.sys?.sunrise ?? 0)) (sunrise)"
        self.groundLevel.text = "\(DateTimeHelper.convertToDateTimeFromTimeStamp(timeStamp: result?.sys?.sunset ?? 0)) (sunset)"
    }
}
