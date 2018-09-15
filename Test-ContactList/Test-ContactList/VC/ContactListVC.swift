//
//  ContactListVC.swift
//  Test-ContactList
//
//  Created by Ivan OSYPENKO on 9/14/18.
//  Copyright © 2018 iosypenk's team. All rights reserved.
//

import UIKit

class ContactListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let contactsData = GetContactInfo()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datarequest()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsVC else { return }
        detailsVC.personData = self.contactsData
        detailsVC.index = tableView.indexPathForSelectedRow?.row
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsData.contactsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsCell
        let person = contactsData.contactsArr[indexPath.row]
        cell.initCell(person: person)
        return cell
    }

    fileprivate func datarequest() {
        contactsData.getInfo { (res, error) in
            DispatchQueue.main.async {
                if res {
                    self.contactsData.getArr()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

