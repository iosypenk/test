//
//  ContactListVC.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

class ContactListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let data = GetContactInfo()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datarequest()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.contactsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsCell
        let person = data.contactsArr[indexPath.row]
            cell.initCell(person: person)
    
        return cell
    }

    fileprivate func datarequest() {
        data.getInfo { (res, error) in
            DispatchQueue.main.async {
                if res {
                    print("getinfo")
                    self.data.getArr()
                    self.tableView.reloadData()
                }
            }
        }
    }
}
