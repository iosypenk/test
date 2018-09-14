//
//  ContactsCell.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit



struct Page : Decodable {
    let href : String?
}

class ContactsCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    func initCell(person: Person) {
        if let name = person.firstName {
            fullNameLabel.text = name
        }
        if let avatar = person.avatar {
            let path = test(urlString: avatar)
            getAvatar(urlString: avatar, tmp: path)
        }
    }
    
    private func getAvatar(urlString: String, tmp: String?) {
        guard let tmp = tmp else { return }

        var arr = urlString.components(separatedBy: "/File:")
        let index = arr.count - 1
        let adr = arr[index]
        let fullURL = "https://upload.wikimedia.org/wikipedia/en/\(tmp)/\(adr)"
        
        if let url : URL = URL(string : fullURL) {
        
            let session = URLSession(configuration: .default)
            let getImgFromUrl = session.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    print("Error Occurred: \(error)")
                } else {
                    if (response as? HTTPURLResponse) != nil {
                        if let data = data {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.avatarView.image = image
                            }
                        }
                    }
                }
            }
            getImgFromUrl.resume()
        }
    }
    
    /*func download(urlString: String) {
          if let url : URL = URL(string : urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    self.avatarView.image = UIImage(data: data!)
                }
            }.resume()
            
        }
    }*/
    
    func test(urlString: String) -> String? {
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

    /*func download2(urlString: String) {
        if let url : URL = URL(string : urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                   
                    
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
                }.resume()
            
        }*/
        
        
    

   
    
    
    
    
    
}


