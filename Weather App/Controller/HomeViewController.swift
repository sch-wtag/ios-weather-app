//
//  HomeViewController.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    @IBOutlet weak var table: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupTable()
        
        fetchData()
    }
    
    private func setupTable() {
        table.register(TemperatureTableViewCell.nib(), forCellReuseIdentifier: TemperatureTableViewCell.cellName)
        table.register(InformationTableViewCell.nib(), forCellReuseIdentifier: InformationTableViewCell.cellName)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        
        table.delegate = self
        table.dataSource = self
        table.refreshControl = refreshControl
        table.refreshControl?.tintColor = .white
    }
    
    @objc func pullToRefresh(sender: UIRefreshControl) {
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchCurrentWeatherInfo()
    }
}

extension HomeViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return showTableCell(tableView: tableView, indexPath: indexPath)
    }
    
    func showTableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case TableCell.TemperatureCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.cellName, for: indexPath) as! TemperatureTableViewCell
            let cellViewModel = TemperatureTableViewCellViewModel(weatherData: viewModel.getWeatherResponse())
            cell.viewModel = cellViewModel
            return cell
        case TableCell.InformationCell.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.cellName, for: indexPath) as! InformationTableViewCell
            let cellViewModel = InformationTableViewCellViewModel(weatherData: viewModel.getWeatherResponse())
            cell.viewModel = cellViewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    enum TableCell: Int {
        case TemperatureCell = 0
        case InformationCell = 1
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.table.reloadData()
            self.table.refreshControl?.endRefreshing()
        }
    }
    
    func showError() {
        print(viewModel.getError())
    }
}
