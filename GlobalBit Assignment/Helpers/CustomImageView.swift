//
//  CustomImageView.swift
//  GlobalBit Assignment
//
//  Created by Itzik Bar-Noy on 26/05/2020.
//  Copyright © 2020 Itzik Bar-Noy. All rights reserved.
//

import UIKit
import SVGKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
    }
    
    public func loadImageUsingUrlString(urlString: String, completion: @escaping (_ finish: Bool?) -> ()) {
        imageUrlString = urlString
        
        if let url = URL(string: urlString) {
            if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
                self.image = imageFromCache
                completion(true)
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    completion(false)
                    return
                }
                
                // check if the suffix of the image path is "svg" if so, then use SVGKit to read the data.
                let suffix = urlString.suffix(3)
                let imageToCache = (suffix == "svg") ? SVGKImage(data: data).uiImage : UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                        completion(true)
                    }
                }
                
                if let imageToCache = imageToCache {
                    imageCache.setObject(imageToCache, forKey: NSString(string: urlString))
                }
            }).resume()
        }
    }
}
