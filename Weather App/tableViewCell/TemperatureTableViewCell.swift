//
//  TemperatureTableViewCell.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/28/24.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    
    static let cellName = "TemperatureTableViewCell"
    
    var viewModel: TemperatureTableViewCellViewModel? {
        didSet {
            self.updateCellUI()
        }
    }
    
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
    
    private func updateCellUI() {
        let result = viewModel?.weatherData
        
        self.coordinates?.text = "\((result?.coord?.lat ?? 0.0).rounded(toPlaces: 3)), \((result?.coord?.lon ?? 0.0).rounded(toPlaces: 3))"
        self.location?.text = "\(result?.sys?.country ?? "")"
        self.iconImage?.loadNetworkImage(url: "\(Constants.IMAGE_BASE_URL)\(result?.weather?.last?.icon ?? "")@2x.png")
        self.weatherDescription.text = result?.weather?.last?.description ?? ""
        self.temperature?.text = "\((result?.main?.temp ?? 0.0).toCelciusFormat())"
        self.feelsLikeTemp?.text = "feels like \((result?.main?.feels_like ?? 0.0).toCelciusFormat())"
        self.minMaxTemp?.text = "Min \((result?.main?.temp_min ?? 0.0).toCelciusFormat()), Max \((result?.main?.temp_max ?? 0.0).toCelciusFormat())"
    }
}
