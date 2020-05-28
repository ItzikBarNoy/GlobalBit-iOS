//
//  CountryDataModel.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 27/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import Foundation

class CountryDataModel {
    
    // MARK: Properties
    private var country: Country
    private let utility = Utility()
    
    var isFavorited = false
    var timezons: String = ""
    var displayedTimes: String = ""
    
    var name: String {
        return country.name
    }
    
    var capital: String {
        return "Capital city: " + (country.capital != "" ? country.capital : "N/A")
    }
    
    var flag: String {
        return country.flag
    }
    
    var population: String? {
        return country.population.getThousandSeparator()
    }
    
    var nativeName: String {
        return country.nativeName
    }
    
    var alpha3Code: String {
        return country.alpha3Code
    }
    
    var languages: String {
        var allLanguages = ""

        for (index, language) in country.languages.enumerated() {
            if index + 1 < country.languages.count {
                allLanguages += language.name + ", "
            } else {
                allLanguages += language.name
            }
        }
        
        return allLanguages
    }
    
    var translations: String {
        var allTranslations = ""
        
        let br = country.translations.br, de = country.translations.de
        let es = country.translations.es, fa = country.translations.fa
        let fr = country.translations.fr, hr = country.translations.hr
        let it = country.translations.it, ja = country.translations.ja
        let nl = country.translations.nl, pt = country.translations.pt
        
        allTranslations += "\(br), "
        allTranslations += de != nil ? "\(de!), " : ""
        allTranslations += es != nil ? "\(es!), " : ""
        allTranslations += "\(fa), "
        allTranslations += fr != nil ? "\(fr!), " : ""
        allTranslations += hr != nil ? "\(hr!), " : ""
        allTranslations += it != nil ? "\(it!), " : ""
        allTranslations += ja != nil ? "\(ja!), " : ""
        allTranslations += nl != nil ? "\(nl!), " : ""
        allTranslations += "\(pt)"
        
        return allTranslations
    }
    
    init(country: Country, isFavorited: Bool = false) {
        self.country = country
        self.isFavorited = isFavorited
        initTimezones(with: country.timezones)
    }
    
    // MARK: Functions
    private func initTimezones(with timezones: [String]) {
        let times = utility.generateTime(for: timezones)
        for (index, time) in times.enumerated() {
            let endLine = ((index + 1 < timezones.count) ? "\n" : "")
            timezons += timezones[index] + endLine
            displayedTimes += time + endLine
        }
    }
}
