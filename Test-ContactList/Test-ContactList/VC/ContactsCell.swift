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
            ImageService.getImage(urlString: avatar, complitionHandler: { (img) in
                DispatchQueue.main.async {
                    if let image = img {
                        self.avatarView.image = image
                    }
                }
            })
        }
    }
    
}


