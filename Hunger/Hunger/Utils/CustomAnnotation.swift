//
//  CustomAnnotation.swift
//  Hunger
//
//  Created by Guilherme Viana on 20/03/2024.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
	var item: MKMapItem
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var category: String

	init(item: MKMapItem,
		 coordinate: CLLocationCoordinate2D,
		 title: String,
		 category: String) {
		self.item = item
		self.coordinate = coordinate
		self.title = title
		self.category = category
	}
}
