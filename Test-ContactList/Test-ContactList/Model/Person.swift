//
//  Person.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

struct Person: Decodable {
    let firstName : String?
    let secondName : String?
    let avatar : String?
    let age : Int?
}

struct Employees: Decodable {
    let person1 : Person?
    let person2 : Person?
    let person3 : Person?
    let person4 : Person?
    let person5 : Person?
}

struct Contacts : Decodable {
    let employees : Employees?
}

struct PersonData {
    var info: Person?
    var image: UIImage?
}

class GetContactInfo {
    
    var contactsArr = [Person]()
    var contacts : Contacts?
    
    func getInfo(complitionhandler: @escaping (Bool, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.contacts = try JSONDecoder().decode(Contacts.self, from: data) as Contacts?
                complitionhandler(true, nil)
            } catch {
                print("Error: can not read json file")
                complitionhandler(false, error)
            }
        }
    }

    func downloadImage(url: URL) {
          print("start")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error")
                return
            }

            DispatchQueue.main.async {
//                self.avatarView.image = UIImage(data: data!)
                print("main")
            }
            }.resume()
         print("finish")
    }
    
    func downloadImage(url: URL, complitionHandler: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error")
                complitionHandler(nil, error)
                return
            }
            
            DispatchQueue.main.async {
                complitionHandler(UIImage(data: data!), nil)
                //                self.avatarView.image = UIImage(data: data!)
                print("main")
            }
            }.resume()
    }
    
    

    
    
    func getArr() {
        
        guard let employees = self.contacts?.employees else { return }
        
//        if let person = employees.person1 {
//            var newPerson = PersonData()
//            newPerson.info = person
//            if let urlString = person.avatar {
//                if let url = URL(string: urlString){
////                    downloadImage(url: url)
//                    downloadImage(url: url, complitionHandler: { (image, error) in
//                        DispatchQueue.main.async {
//                            if let image = image {
//                                newPerson.image = image
//                            }
//                        }
//                    })
//                }
//            }
//            contactsArr.append(newPerson)
//        }
//        if let person = employees.person2 {
//            var newPerson = PersonData()
//            newPerson.info = person
//            contactsArr.append(newPerson)
//        }
//        if let person = employees.person3 {
//            var newPerson = PersonData()
//            newPerson.info = person
//            contactsArr.append(newPerson)
//        }
//        if let person = employees.person4 {
//            var newPerson = PersonData()
//            newPerson.info = person
//            contactsArr.append(newPerson)
//        }
//        if let person = employees.person5 {
//            var newPerson = PersonData()
//            newPerson.info = person
//            contactsArr.append(newPerson)
//        }
        
        if let person = employees.person1 {
            contactsArr.append(person)
        }
        if let person = employees.person2 {
            contactsArr.append(person)
        }
        if let person = employees.person3 {
            contactsArr.append(person)
        }
        if let person = employees.person4 {
            contactsArr.append(person)
        }
        if let person = employees.person5 {
            contactsArr.append(person)
        }
    }

}

