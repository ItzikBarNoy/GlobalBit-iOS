//
//  FavoritesCountriesViewController.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 27/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class FavoritesCountriesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    public static let identifier = "FavoritesCountries"
    public var favoritesCountries: [CountryDataModel]?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesCountries = favoritesCountries?.sorted(by: { $0.name < $1.name })
        configurePage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar bottom line (hide shadow)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    // MARK: Functions
    private func configurePage() {
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CountryDetailsViewController.identifier {
            if let viewController = segue.destination as? CountryDetailsViewController {
                if let index = sender as? Int {
                    viewController.country = favoritesCountries![index]
                }
            }
        }
    }
}

extension FavoritesCountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCountryTableViewCell.identifier) as? FavoriteCountryTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(with: favoritesCountries![indexPath.row])
        
        return cell
    }
}

extension FavoritesCountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CountryDetailsViewController.identifier, sender: indexPath.row)
    }
}
