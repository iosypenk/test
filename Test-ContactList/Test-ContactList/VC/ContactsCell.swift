//
//  ContactsCell.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    func initCell(person: Person) {
        if let name = person.firstName {
            fullNameLabel.text = name
        }
        if let avatar = person.avatar {
            getAvatar(urlString: avatar)
        }
    }
    
    private func getAvatar(urlString: String) {
        
        if let url : URL = URL(string : urlString) {
        let session = URLSession(configuration: .default)
        let getImgFromUrl = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print("Error Occurred: \(error)")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            print("zashlo")
                            self.avatarView.image = image
                        }
                    }
                }
            }
        }
        getImgFromUrl.resume()
        }
    }
    

   
    
    
    
    
    
}


