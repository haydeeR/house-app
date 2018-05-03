//
//  HouseDetailViewController.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var typeOfView = 0
    
    fileprivate enum tableRowTypes: Int {
        case image
        case address
        case price
        case details
    }
    fileprivate let rowAmount = 4
    fileprivate let textCellIdentifier = "cell"
    var house: House?
    var houseList: [House] = []
    
    override func viewDidLoad() {
        setupTableView()
        registerCells()
        getHousesByLocation()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func registerCells() {
        var nib = UINib(nibName: HomeImageTableViewCell.reusableId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HomeImageTableViewCell.reusableId)
        nib = UINib(nibName: MapReusableCell.reusableId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MapReusableCell.reusableId)
    }
    
    @IBAction func changeViewAction(_ sender: UISegmentedControl) {
        typeOfView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    func getHousesByLocation() {
        Handler.getLists().map ({ houselist in
            self.houseList = houselist
            let houseFilter = self.houseList.filter({ (house) -> Bool in
                house.state == self.house?.state as! String
            })
            self.houseList = houseFilter
        })
        .done {
            self.tableView.reloadData()
        }
        .catch({ error -> Void in
            print(error)
        })
    }
}

extension HouseDetailViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeOfView == TypeView.map.rawValue {
            return 1
        }
        return rowAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellText: String?
        var cellImage: UIImage?
        
        if typeOfView == TypeView.map.rawValue {
            return createCell()
        }
        if let house = house {
            switch indexPath.row {
            case tableRowTypes.image.rawValue:
                cellImage = house.image
            case tableRowTypes.address.rawValue:
                cellText = house.address
                break;
            case tableRowTypes.price.rawValue:
                cellText = "$\(house.price)"
                break;
            case tableRowTypes.details.rawValue:
                cellText = house.description
                break;
            default:
                break;
            }
        }
        return createCell(with: indexPath.row, cellText: cellText, cellImage: cellImage)
    }
    
    private func createCell() -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MapReusableCell.reusableId) as? MapReusableCell)!
        cell.configure(with: houseList)
        return cell
    }
    
    private func createCell(with type: Int, cellText: String?, cellImage: UIImage?) -> UITableViewCell {
        switch type {
        case tableRowTypes.image.rawValue:
            let cell = (tableView.dequeueReusableCell(withIdentifier: HomeImageTableViewCell.reusableId) as? HomeImageTableViewCell)!
            cell.configureWith(cellImage)
            return cell
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier)
            if let cell = cell {
                cell.textLabel?.text = cellText
            }else {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: textCellIdentifier)
                cell?.textLabel?.text = cellText
            }
            return cell!
        }
    }
}

extension HouseDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeOfView == TypeView.map.rawValue {
            return tableView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
}

