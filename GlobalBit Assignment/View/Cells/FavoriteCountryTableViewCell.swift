//
//  FavoriteCountryTableViewCell.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 27/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class FavoriteCountryTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var flagCustomImageView: CustomImageView!
    
    // MARK: Properties
    public static let identifier = "FavoritesCountryCell"
    private let utility = Utility()
    
    public func configureCell(with country: CountryDataModel) {
        countryCodeLabel.text = country.alpha3Code
        utility.initCustomImageView(for: flagCustomImageView, with: country.flag)
    }
}
