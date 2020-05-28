//
//  WebServices.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import Foundation

class WebServices: ApiClient {
    
    let urlString = "https://restcountries.eu/rest/v2/all"
    
    public func getCountries(completion: @escaping ([Country]?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        fetch(with: url) { (result: Result<[Country]>) in
            switch result {
            case .success(let countries):
                completion(countries)
            case .failure:
                completion(nil)
            }
        }
    }
}
