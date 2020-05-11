//
//  ViewController.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    private let networkManager: NetworkManagerDescription = NetworkManager.shared
    private var chooseCountry = ["All"]
    private var chosenCountry: String = "Russian Federation"
    private var countries: Timeseries?
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newConfirmed: UILabel!
    
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    
    @IBOutlet weak var lastUpdateDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Covidec"
        downloadJSON()
    }
    
    private func updateInfo() {
        self.chooseCountry = ["All"]
        let chosenCountry = self.chosenCountry
        
        if chosenCountry == "All" {
            guard let global = self.countries?.Global else { return }
            self.countryLabel.text = chosenCountry
            
            self.totalConfirmed.text = "\(global.TotalConfirmed)"
            self.newConfirmed.text = "+\(global.NewConfirmed)"
            
            self.totalDeaths.text = "\(global.TotalDeaths)"
            self.newDeaths.text = "+\(global.NewDeaths)"
            
            self.totalRecovered.text = "\(global.TotalRecovered)"
            self.newRecovered.text = "+\(global.NewRecovered)"
        }
        
        guard let countries = self.countries?.Countries else { return }
            
        for country in countries {
            self.chooseCountry.append(country.Country)
            if country.Country == chosenCountry {
                
                DispatchQueue.main.async {
                    self.countryLabel.text = chosenCountry
                    
                    self.totalConfirmed.text = "\(country.TotalConfirmed)"
                    self.newConfirmed.text = "+\(country.NewConfirmed)"
                    
                    self.totalDeaths.text = "\(country.TotalDeaths)"
                    self.newDeaths.text = "+\(country.NewDeaths)"
                    
                    self.totalRecovered.text = "\(country.TotalRecovered)"
                    self.newRecovered.text = "+\(country.NewRecovered)"
                    
                    let isoDate = country.Date
                    
                    let dateFormatter = ISO8601DateFormatter()
                    let date = dateFormatter.date(from:isoDate)!
                    
                    self.lastUpdateDate.text = "\(date)"
                }
            }
        }
        
        //        print(self.chooseCountry)
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        downloadJSON()
    }
    
    func downloadJSON() {
        self.networkManager.loadCountries { [weak self] (countriesJSON) in
            guard let countriesJSON = countriesJSON else {
                return
            }
            self?.countries = countriesJSON
            self?.updateInfo()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let countryVC = CountryTableViewController()
            countryVC.poolOfCountries = self.chooseCountry
            navigationController?.pushViewController(countryVC, animated: true)
            countryVC.completion = {[weak self] newCountry in
                DispatchQueue.main.async {
//                    print(newCountry)
                    self?.chosenCountry = newCountry
                    self?.updateInfo()
                }
                
            }
//            navigationController?.pushViewController(countryVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
