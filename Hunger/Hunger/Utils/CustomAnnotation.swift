//
//  CustomAnnotation.swift
//  Hunger
//
//  Created by Guilherme Viana on 20/03/2024.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D
	var location: CLLocation
	var title: String?
	var category: String

	init(coordinate: CLLocationCoordinate2D,
		 location: CLLocation,
		 title: String,
		 category: String) {
		self.coordinate = coordinate
		self.location = location
		self.title = title
		self.category = category
	}
}
