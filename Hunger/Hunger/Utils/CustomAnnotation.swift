//
//  CustomAnnotation.swift
//  Hunger
//
//  Created by Guilherme Viana on 20/03/2024.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
		var coordinate: CLLocationCoordinate2D
		var title: String?
		var category: String

		init(coordinate: CLLocationCoordinate2D, title: String, category: String) {
			self.coordinate = coordinate
			self.title = title
			self.category = category
		}
}

class ClusterAnnotationView: MKMarkerAnnotationView {
	override var annotation: MKAnnotation? {
		willSet {
			if let cluster = newValue as? MKClusterAnnotation {
				markerTintColor = .systemBlue
				glyphText = String(cluster.memberAnnotations.count) 
			}
		}
	}
}
