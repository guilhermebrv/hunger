//
//  RestaurantResultsViewModel.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import MapKit

struct RestaurantResultsViewModel {
	var restaurantsList: [MKMapItem]?

	public var numberOfRowsInSection: Int {
		guard let restaurantsList else { return 0 }
		return restaurantsList.count
	}

	public var heightForRowAt: CGFloat {
		160
	}

	public func distanceFromUser(_ restaurant: MKMapItem, _ location: CLLocation) -> Int {
		let distanceInMeters = location.distance(from: restaurant.placemark.location ?? CLLocation())
		return Int(distanceInMeters)
	}

	public mutating func filterResultsRadius(from response: MKLocalSearch.Response, radius: CLLocationDistance,
											 location: CLLocation) -> [MKMapItem] {
		let filteredItems = response.mapItems.filter { item in
			let itemLocation = CLLocation(latitude: item.placemark.coordinate.latitude,
										  longitude: item.placemark.coordinate.longitude)
			return location.distance(from: itemLocation) <= radius
		}
		.sorted { (item1, item2) -> Bool in
			let distance1 = location.distance(from: CLLocation(latitude: item1.placemark.coordinate.latitude,
																   longitude: item1.placemark.coordinate.longitude))
			let distance2 = location.distance(from: CLLocation(latitude: item2.placemark.coordinate.latitude,
																   longitude: item2.placemark.coordinate.longitude))
			return distance1 < distance2
		}
		restaurantsList = filteredItems
		return restaurantsList ?? [MKMapItem]()
	}
}
