//
//  RestaurantsMapViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 18/03/2024.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantsMapViewController: UIViewController {
	var mapView: RestaurantsMapView?
	let locationManager: CLLocationManager
	let radiusDistance: CLLocationDistance
	let foodType: String
	let restaurantsList: [MKMapItem]

	init(locationManager: CLLocationManager, radiusDistance: CLLocationDistance, foodType: String, restaurantsList: [MKMapItem]) {
		self.locationManager = locationManager
		self.radiusDistance = radiusDistance
		self.foodType = foodType
		self.restaurantsList = restaurantsList
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		mapView = RestaurantsMapView()
		view = mapView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		showRestaurantsOnMap()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		locationManager.startUpdatingLocation()
		locationManager.startUpdatingHeading()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		locationManager.stopUpdatingHeading()
	}
}

extension RestaurantsMapViewController {
	private func signProtocols() {
		locationManager.delegate = self
		mapView?.delegate = self
		mapView?.mapView.delegate = self
	}
}

extension RestaurantsMapViewController: RestaurantsMapViewDelegate {
	func didTapCloseButton() {
		dismiss(animated: true, completion: nil)
	}
}

extension RestaurantsMapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
			locationManager.stopUpdatingLocation()
	}
}

extension RestaurantsMapViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
		if let customAnnotation = annotation as? CustomAnnotation {
				let identifier = "CustomAnnotation"
				var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

				if markerView == nil {
					markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
					markerView?.canShowCallout = true
				} else {
					markerView?.annotation = annotation
				}

				if let markerView = markerView {  
					configMarkerView(for: markerView, annotation: customAnnotation)
				}
				return markerView
			}
		return nil
	}
	private func configMarkerView(for marker: MKMarkerAnnotationView, annotation: CustomAnnotation) {
		marker.glyphTintColor = .secondarySystemBackground
		marker.markerTintColor = .systemOrange

		switch annotation.category {
		case "Cafe", "Bakery":
			marker.glyphImage = UIImage(systemName: "cup.and.saucer.fill")
			marker.markerTintColor = .systemYellow
		default:
			marker.glyphImage = UIImage(systemName: "fork.knife")
			marker.markerTintColor = .systemOrange
		}
	}
	private func showRestaurantsOnMap() {
		guard let map = mapView?.mapView else { return }
		removeAnnotations(from: map)
		addAnotations(on: map, from: restaurantsList)
		map.showAnnotations(map.annotations, animated: true)
	}
	private func removeAnnotations(from map: MKMapView) {
		map.removeAnnotations(map.annotations)
	}
	private func addAnotations(on map: MKMapView, from restaurantsList: [MKMapItem]) {
		var category: String
		for restaurant in restaurantsList {
			switch foodType {
			case "Cafe", "Bakery":
				category = "Cafe"
			default:
				category = ""
			}
			let annotation = CustomAnnotation(coordinate: restaurant.placemark.coordinate,
											  title: restaurant.name ?? "",
											  category: category)
			map.addAnnotation(annotation)
		}
	}
}
