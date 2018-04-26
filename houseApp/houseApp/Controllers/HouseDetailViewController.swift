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
    
    fileprivate enum tableRowTypes: Int {
        case image
        case address
        case price
        case details
    }
    fileprivate let rowAmount = 4
    fileprivate let textCellIdentifier = "cell"
    var house: House?
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: HomeImageTableViewCell.reusableId, bundle: nil), forCellReuseIdentifier: HomeImageTableViewCell.reusableId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configure(house: House) {
        self.house = house
    }
    
}

extension HouseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellText: String?
        var cellImage: UIImage?
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
        if indexPath.row == tableRowTypes.image.rawValue {
            var cell = tableView.dequeueReusableCell(withIdentifier: HomeImageTableViewCell.reusableId) as? HomeImageTableViewCell
            if cell == nil {
                cell = HomeImageTableViewCell.init(style: .default, reuseIdentifier: HomeImageTableViewCell.reusableId)
            }
            cell?.configureWith(cellImage)
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: textCellIdentifier)
            }
            cell?.textLabel?.text = cellText
            return cell!
        }
    }
    
}

