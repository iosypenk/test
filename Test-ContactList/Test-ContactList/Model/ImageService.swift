//
//  ImageService.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/15/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()

    static func getImage(urlString: String, complitionHandler: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: urlString as NSString) {
            complitionHandler(image)
        } else {
            downloadAvatar(urlString: urlString, complitionHandler: complitionHandler)
        }
    }
    
    fileprivate static func downloadAvatar(urlString: String, complitionHandler: @escaping (UIImage?) -> Void) {
        
        guard let path = self.getImagePath(urlString: urlString) else { return }
        
        var arr = urlString.components(separatedBy: "/File:")
        let index = arr.count - 1
        let adr = arr[index]

        let fullURL = "https://upload.wikimedia.org/wikipedia/en/\(path)/\(adr)"
        
        if let url : URL = URL(string : fullURL) {
            
            let session = URLSession(configuration: .default)
            let getImgFromUrl = session.dataTask(with: url) {(data, response, error) in
                
                var dowloadedImage: UIImage?
                
                if let error = error {
                    print("Error Occurred: \(error)")
                } else {
                    if (response as? HTTPURLResponse) != nil {
                        if let data = data {
                            dowloadedImage = UIImage(data: data)

                            if dowloadedImage != nil {
                                cache.setObject(dowloadedImage!, forKey: urlString as NSString)
                            }
                            
                            DispatchQueue.main.async {
                                complitionHandler(dowloadedImage)
                            }
                        }
                    }
                }
            }
            getImgFromUrl.resume()
        }
    }
    
    fileprivate static func getImagePath(urlString: String) -> String? {
        if let url : URL = URL(string : urlString) {
            
            do {
                let contents = try String(contentsOf: url)
                if contents.contains("upload.wikimedia.org/wikipedia/en/") {
                    let tmp = contents.components(separatedBy: "upload.wikimedia.org/wikipedia/en/")
                    let tmp2 = tmp[1]
                    let res : String = String(tmp2.prefix(4))
                    return res
                }
            } catch {
                print("error")
            }
            
        } else {
            print("bad url")
        }
        return nil
    }
}
