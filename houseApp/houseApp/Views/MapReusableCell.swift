//
//  MapReusableCell.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/26/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit
import MapKit

class MapReusableCell: UITableViewCell {

    @IBOutlet weak var map: MKMapView!
    var houses: [House] = []
    private let regionRadius: CLLocationDistance = 5500
    var tableViewParent: HomeListTableViewController?
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with houses: [House]) {
        map.delegate = self
        self.houses = houses
        for house in houses {
           setMarket(house: house)
        }
    }
    
    func setMarket(house: House) {
        let market = HouseMarket.init(house: house)
        let location = house.location
        market.coordinate = CLLocationCoordinate2D.init(latitude: location.latitude!,
                                                            longitude: location.longitude!)
        map.addAnnotation(market)
    }
    
    private func showMyLocation() {
        LocationService.sharedInstance.getLocation { currentLocation in
            self.focusNewLocation(location: currentLocation)
        }
    }
    
    private func focusNewLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
}

extension MapReusableCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let description = view.annotation?.title else { return }
        let possiblesHouses = houses.filter { house -> Bool in
            house.description == description
        }
        let selectedHouse = possiblesHouses[0]
        tableViewParent?.configureDetailsView(house: selectedHouse)
    }
}

