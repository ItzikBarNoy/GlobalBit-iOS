//
//  CountryTableViewCell.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

protocol CountryFavoriteDelegate {
    func favoriteTappedHandle(for cell: UITableViewCell)
}

class CountryTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagCustomImageView: CustomImageView!
    @IBOutlet weak var capitalCityLabel: UILabel!
    @IBOutlet weak var timezonesLabel: UILabel!
    @IBOutlet weak var displayedTimesLabel: UILabel!
    @IBOutlet weak var isFavoritedButton: UIButton!
    
    // MARK: Properties
    public static let identifier = "CountryCell"
    private let utility = Utility()
    var countryFavoriteDelegate: CountryFavoriteDelegate!
    
    // MARK: Actions
    @IBAction func isFavoritedButtonTapped(_ sender: UIButton) {
        countryFavoriteDelegate.favoriteTappedHandle(for: self)
    }
    
    // MARK: Functions
    public func configureCell(with country: CountryDataModel) {
        countryNameLabel.text = country.name
        timezonesLabel.text = country.timezons
        displayedTimesLabel.text = country.displayedTimes
        
        capitalCityLabel.changeTextColorPartially(fullText: country.capital, textForColoring: "Capital city: ", with: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        utility.initCustomImageView(for: flagCustomImageView, with: country.flag)
        setFavoriteIconColor(isFavorited: country.isFavorited)
    }
    
    private func setFavoriteIconColor(isFavorited: Bool) {
        let starImage = UIImage(named: "star")
        let tintedImage = starImage?.withRenderingMode(.alwaysTemplate)
        isFavoritedButton.setImage(tintedImage, for: .normal)
        if isFavorited {
            isFavoritedButton.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            isFavoritedButton.tintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        }
    }
}
