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
    var rate : Bool?
}

struct Employees: Decodable {
    var person1 : Person?
    var person2 : Person?
    var person3 : Person?
    var person4 : Person?
    var person5 : Person?
}

struct Contacts : Decodable {
    let employees : Employees?
}

class GetContactInfo {
    
    var contactsArr = [Person]()
    var contacts : Contacts?
    
    //parsing json file
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
    
    //creation of array of Employees
    func getArr() {
        guard let employees = self.contacts?.employees else { return }
        
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

