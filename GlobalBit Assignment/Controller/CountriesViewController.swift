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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    private let userDefaults = UserDefaults.standard
    private let webServices = WebServices()
    private var favoritesCountries = [CountryDataModel]()
    private var filteredCountries = [CountryDataModel]()
    private var countries = [CountryDataModel]() {
        didSet {
            setCountriesArray()
            self.tableView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternetConnection()
        loadCountries()
        configurePage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar bottom line (hide shadow)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    // MARK: Functions
    private func setCountriesArray() {
        filteredCountries = countries
        favoritesCountries = filteredCountries.filter { $0.isFavorited }
    }
    
    private func checkInternetConnection() {
        if !InternetConnectionManager.isConnectedToNetwork() {
            showGenericError(title: "Internet connection failed", message: "Try to reach the data from cache")
        }
    }
    
    private func loadCountries() {
        webServices.getCountries(completion: { countries in
            if let countries = countries {
                self.countries = countries.map {
                    CountryDataModel(country: $0, isFavorited: (self.userDefaults.object(forKey: $0.name) != nil))
                }
                self.removeProblematicCell()
            } else {
                self.showGenericError(title: "Cannot load data", message: "Cannot read the data from the json file")
            }
        })
    }
    
    // MARK: This specific country cannot be loaded
    private func removeProblematicCell() {
        if let index = countries.firstIndex(where: { $0.name == "Saint Helena, Ascension and Tristan da Cunha" }) {
            countries.remove(at: index)
        }
    }
    
    private func configurePage() {
        configureTableView()
        configureNavigationBar()
        configureSearchBar()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    private func configureSearchBar() {
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = #colorLiteral(red: 0.9960784314, green: 1, blue: 1, alpha: 1)
    }
    
    private func addToFavoriteCountriesArray(country: CountryDataModel) {
        favoritesCountries.append(country)
        userDefaults.set(true, forKey: country.name)
    }
    
    private func removeFromFavoriteCountriesArray(country: CountryDataModel) {
        guard let index = favoritesCountries.firstIndex(where: { $0.name == country.name } ) else { return }
        userDefaults.removeObject(forKey: country.name)
        favoritesCountries.remove(at: index)
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CountryDetailsViewController.identifier {
            if let viewController = segue.destination as? CountryDetailsViewController {
                if let index = sender as? Int {
                    viewController.country = filteredCountries[index]
                }
            }
        }
        
        if segue.identifier == FavoritesCountriesViewController.identifier {
            if let viewController = segue.destination as? FavoritesCountriesViewController {
                viewController.favoritesCountries = favoritesCountries
            }
        }
    }
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.countryFavoriteDelegate = self
        cell.configureCell(with: filteredCountries[indexPath.row])
        
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CountryDetailsViewController.identifier, sender: indexPath.row)
    }
}

extension CountriesViewController: CountryFavoriteDelegate {
    
    func favoriteTappedHandle(for cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let country = filteredCountries[indexPathTapped.row]
        country.isFavorited = !country.isFavorited
        
        if country.isFavorited {
            addToFavoriteCountriesArray(country: country)
        } else {
            removeFromFavoriteCountriesArray(country: country)
        }
        
        tableView.reloadData()
    }
}

// MARK: Handle custom delegate
extension CountriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            filteredCountries = countries.filter { $0.name.lowercased().contains(text.lowercased()) }
        } else {
            filteredCountries = countries
        }
        
        tableView.reloadData()
    }    
}
