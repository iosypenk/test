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
        
        avatarView.layer.borderWidth = 1
        avatarView.layer.masksToBounds = false
        avatarView.layer.borderColor = UIColor.lightGray.cgColor
        avatarView.layer.cornerRadius = avatarView.frame.width/2
        avatarView.clipsToBounds = true
        
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


