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
    
    private let viewModel = HomeViewModel(service: WeatherNetworkService.instance)
    
    @IBOutlet weak var table: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(TemperatureTableViewCell.nib(), forCellReuseIdentifier: TemperatureTableViewCell.cellName)
        table.register(InformationTableViewCell.nib(), forCellReuseIdentifier: InformationTableViewCell.cellName)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        
        table.delegate = self
        table.dataSource = self
        table.refreshControl = refreshControl
        table.refreshControl?.tintColor = .white
        
        fetchData()
    }
    
    @objc func pullToRefresh(sender: UIRefreshControl) {
        fetchData()
    }
    
    private func fetchData() {
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
            self.table.refreshControl?.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return showTableCell(tableView: tableView, indexPath: indexPath)
    }
    
    func showTableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.cellName, for: indexPath) as! TemperatureTableViewCell
            let result = viewModel.getResponse()
            cell.updateData(
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
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.cellName, for: indexPath) as! InformationTableViewCell
            let result = viewModel.getResponse()
            cell.updateData(
                airSpeed: "\(result?.wind?.speed ?? 0)",
                airPressure: "\(result?.main?.pressure ?? 0)",
                humidity: "\(result?.main?.humidity ?? 0)",
                sunrise: "\(convertToDateTime(timeStamp: result?.sys?.sunrise ?? 0))",
                sunset: "\(convertToDateTime(timeStamp: result?.sys?.sunset ?? 0))"
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
