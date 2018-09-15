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
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let i = index  {
            initProfile(person: personData?.contactsArr[i])
        }
    }
    
    func initProfile(person: Person?){
     
        guard let person = person else { return }
        
        firstName.text = person.firstName
        secondName.text = person.secondName
        
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


}

