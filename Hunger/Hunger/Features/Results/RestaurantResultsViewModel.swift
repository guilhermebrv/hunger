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
		170
	}
}
