//
//  ViewController.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    var personData: GetContactInfo?
    var index: Int?
    
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var starView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondName: UILabel!
    
    @IBOutlet weak var detailsFirstName: UILabel!
    @IBOutlet weak var detailsSecondName: UILabel!
    @IBOutlet weak var detailsAge: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let i = index  {
            initProfile(person: personData?.contactsArr[i])
        }
        makeAvatarRounded()
    }
    
    func makeAvatarRounded() {
        avatarView.layer.borderWidth = 1
        avatarView.layer.masksToBounds = false
        avatarView.layer.borderColor = UIColor.lightGray.cgColor
        avatarView.layer.cornerRadius = avatarView.frame.width/2
        avatarView.clipsToBounds = true
    }
    func initProfile(person: Person?) {
     
        guard let person = person else { return }
        
        if let star = person.rate{
            if star == true {
                starView.isHidden = false
            }
        }
        
        firstName.text = person.firstName
        secondName.text = person.secondName
        detailsFirstName.text = person.firstName
        detailsSecondName.text = person.secondName
        if let ageInt = person.age {
            let age: String = String(ageInt)
            detailsAge.text = age
        }
     
        if let imgUrl = person.avatar {
            ImageService.getImage(urlString: imgUrl, complitionHandler: { (image) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.avatarView.image = image
                    }
                }
            })
        }
    
    }

    @IBAction func setStar(_ sender: UIButton) {
        guard let i = index else { return }
        guard let person = personData?.contactsArr[i] else { return }
        if let star = person.rate {
            starView.isHidden = !starView.isHidden
            personData?.contactsArr[i].rate = !star
            starLabel.text = (starLabel.text == "Star") ? "Unstar" : "Star"
        } else {
            personData?.contactsArr[i].rate = true
            starView.isHidden = false
            starLabel.text = "Unstar"
        }
        
    }
    
}

