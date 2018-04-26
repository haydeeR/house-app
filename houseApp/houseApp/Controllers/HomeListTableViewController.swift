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
    @IBOutlet weak var segment: UISegmentedControl!
    private var typeOfView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        registerCells()
        getHouses()
    }
    
    private func registerCells() {
        var nib = UINib(nibName: ReusableTableViewCell.reusableId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ReusableTableViewCell.reusableId)
        nib = UINib(nibName: MapReusableCell.reusableId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MapReusableCell.reusableId)
    }
    
    private func getHouses() {
        Handler.getLists().map ({ houselist in
            self.houseList = houselist
                for house in self.houseList {
                    Handler.getHouseImage(house: house, completionHandler: { (image, error) in
                        if let image = image {
                            house.image = image
                        }else {
                            print(error)
                        }
                    })
                }
            })
            .done {
                for i in self.houseList{
                    if let image = i.image {
                        print("Tiene imagen \(image)")
                    }
                    else {
                        print("No hay imagenes")
                    }
                }
                self.tableView.reloadData()
            }
            .catch({ error -> Void in
                print(error)
            })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeOfView == TypeView.map.rawValue {
            return 1
        }
        return houseList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if typeOfView == TypeView.map.rawValue {
            let cell = (tableView.dequeueReusableCell(withIdentifier: MapReusableCell.reusableId, for: indexPath) as? MapReusableCell)!
            cell.configure(with: houseList)
            return cell
        }
        let house = houseList[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.reusableId, for: indexPath) as? ReusableTableViewCell)!
        cell.configure(with: house)
        return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeOfView == TypeView.homelist.rawValue {
        let house = houseList[indexPath.row]
            performSegue(withIdentifier: SegueIdentifier.houseDetail.rawValue, sender: house)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifierString = segue.identifier, let identifier = SegueIdentifier(rawValue: identifierString) else {
            return
        }
        if identifier == SegueIdentifier.houseDetail {
            guard let controller = segue.destination as? HouseDetailViewController else {
                return
            }
            guard let house = sender as? House else {
                return
            }
            controller.house = house
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeOfView == TypeView.map.rawValue {
            return tableView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
    @IBAction func changeViewAction(_ sender: UISegmentedControl) {
        typeOfView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
}
