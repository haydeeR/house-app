//
//  HomeListTableViewController.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit
import PromiseKit

class HomeListTableViewController: UITableViewController {

    private var houseList = [House]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHouses()
    }
    
    private func getHouses() {
        Handler.getLists().map({ houseList -> Void in
            self.houseList = houseList
            })
            .done {
                for item in self.houseList {
                    print ("Casa: \(item.address)")
                }
                self.tableView.reloadData()
            }
            .catch({ error in
                print(error)
            })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let house = houseList[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.reusableId, for: indexPath) as? ReusableTableViewCell)!
            cell.configure(with: house)
           return cell
        }

}
