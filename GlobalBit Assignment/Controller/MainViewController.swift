//
//  CountriesViewController.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private let webServices = WebServices()
    private var countriesDataModel = [CountryDataModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        loadCountries()
    }
    
    // MARK: Functions
    private func loadCountries() {
        webServices.getCountries(completion: { countries in
            if let countries = countries {
                self.countriesDataModel = countries.map { CountryDataModel(country: $0) }
            } else {
                // TODO: show Generic Error
            }
        })
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as! CountryTableViewCell
        cell.configureCell(with: countriesDataModel[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.countryFavoriteDelegate = self
        
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CountryDetailsViewController.identifier, sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CountryDetailsViewController.identifier {
            if let viewController = segue.destination as? CountryDetailsViewController {
                if let index = sender as? Int {
                    viewController.country = countriesDataModel[index]
                }
            }
        }
    }
}

extension CountriesViewController: CountryFavoriteDelegate {
    func handleFavorite(for cell: UITableViewCell) {
        print("handleFavorite")
    }
}
