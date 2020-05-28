//
//  Utility.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 27/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit

class Utility {
    
    public func generateTime(for timezones: [String]) -> [String] {
        var output = [String]()
        for timezone in timezones {
            
            // timezone format: ["U", "T", "C", "+", "0", "0", ":", "0", "0"]
            // indexs format:   | 0    1    2    3    4    5    6    7    8 |
            guard let sign = timezone.substring(from: 3, to: 3) else { continue }
            guard let hoursStr = timezone.substring(from: 4, to: 5) else { continue }
            guard let minutesStr = timezone.substring(from: 7, to: 8) else { continue }
            
            guard let hours = Double(hoursStr), let minutes = Double(minutesStr) else { continue }
               
            let delta = 3600 * hours + 60 * minutes
            let timeToAdd = (sign == "+") ? delta : -delta
            let date = Date().addingTimeInterval(timeToAdd)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            
            let time = dateFormatter.string(from: date)
            output.append(time)
        }
        
        return output
    }
    
    public func initCustomImageView(for customImageView: CustomImageView, with urlString: String) {
        let activityIndicatorView = UIActivityIndicatorView()
        
        customImageView.image = nil
        activityIndicatorView.setup(in: customImageView)
        activityIndicatorView.startAnimating()
        
        customImageView.loadImageUsingUrlString(urlString: urlString, completion: { finish in
            if finish != nil && finish! {
                activityIndicatorView.stopAnimating()
            }
        })
    }
}
