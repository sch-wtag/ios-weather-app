//
//  HomeViewController.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import UIKit

class HomeViewController: BaseViewController,
                          UITableViewDelegate,
                          UITableViewDataSource {
    
    private let viewModel = HomeViewModel()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TemperatureTableViewCell.nib(), forCellReuseIdentifier: TemperatureTableViewCell.cellName)
        table.register(InformationTableViewCell.nib(), forCellReuseIdentifier: InformationTableViewCell.cellName)
        
        table.delegate = self
        table.dataSource = self
        
        viewModel.fetchCurrentWeatherInfo {
            let error = self.viewModel.getError()
            if error == nil {
                self.updateUI()
            } else {
                print(error!)
            }
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.cellName, for: indexPath) as! TemperatureTableViewCell
            let result = viewModel.getResponse()
            cell.bindData(
                coordinates: "\((result?.coord?.lat ?? 0.0).rounded(toPlaces: 3)), \((result?.coord?.lon ?? 0.0).rounded(toPlaces: 3))",
                location: "\(result?.sys?.country ?? "")",
                image: "\(Constants.IMAGE_BASE_URL)\(result?.weather?.last?.icon ?? "")@2x.png",
                description: result?.weather?.last?.description ?? "",
                temperature: "\((result?.main?.temp ?? 0.0).toCelciusFormat())",
                feelsLikeTemp: "\((result?.main?.feels_like ?? 0.0).toCelciusFormat())",
                minTemp: "\((result?.main?.temp_min ?? 0.0).toCelciusFormat())",
                maxTemp: "\((result?.main?.temp_max ?? 0.0).toCelciusFormat())"
            )
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.cellName, for: indexPath) as! InformationTableViewCell
            let result = viewModel.getResponse()
            cell.bindData(
                airSpeed: "\(result?.wind?.speed ?? 0)",
                airPressure: "\(result?.main?.pressure ?? 0)",
                humidity: "\(result?.main?.humidity ?? 0)",
                sunrise: "\(convertToDateTime(timeStamp: result?.sys?.sunrise ?? 0))",
                sunset: "\(convertToDateTime(timeStamp: result?.sys?.sunset ?? 0))"
            )
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 250.0
        if indexPath.row == 1 {
            height = 35
        }
        return height
    }
    
    func convertToDateTime(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatter = DateFormatter()
        let timeZone = TimeZone.current.abbreviation() ?? "BST"
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
