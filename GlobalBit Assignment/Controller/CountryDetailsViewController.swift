//
//  CountryDetailsViewController.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 27/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagCustomImageView: CustomImageView!
    @IBOutlet weak var nativeNameLabel: UILabel!
    @IBOutlet weak var capitalCityLabel: UILabel!
    @IBOutlet weak var timezonesLabel: UILabel!
    @IBOutlet weak var displayedTimesLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var translationsLabel: UILabel!
    
    // MARK: Properties
    public static var identifier = "CountryDetails"
    private let utility = Utility()
    public var country: CountryDataModel?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePage()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar bottom line (hide shadow)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    // MARK: Functions
    private func configurePage() {
        guard let country = country else { return }
        
        countryNameLabel.text = country.name
        timezonesLabel.text = country.timezons
        displayedTimesLabel.text = country.displayedTimes
        nativeNameLabel.text = "Native name: \(country.nativeName)"
        populationLabel.text = "Population: \(country.population ?? "N/A")"
        languagesLabel.text = country.languages
        translationsLabel.text = country.translations
        
        capitalCityLabel.changeTextColorPartially(fullText: country.capital, textForColoring: "Capital city: ", with: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        utility.initCustomImageView(for: flagCustomImageView, with: country.flag)
    }
}
