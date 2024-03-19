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
	let locationManager: CLLocationManager?
	let radiusDistance: CLLocationDistance?
	let restaurantsList: [MKMapItem]?

	init(locationManager: CLLocationManager?, radiusDistance: CLLocationDistance?, restaurantsList: [MKMapItem]?) {
		self.locationManager = locationManager
		self.radiusDistance = radiusDistance
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
		locationManager?.delegate = self
		showRestaurantsOnMap()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		locationManager?.startUpdatingLocation()
		locationManager?.startUpdatingHeading()
	}
}

extension RestaurantsMapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last, let radiusDistance {
			let region = setRegion(for: location, radius: radiusDistance * 2.5)
			DispatchQueue.main.async { self.mapView?.mapView.setRegion(region, animated: true) }
			locationManager?.stopUpdatingLocation()
		}
	}
	private func setRegion(for location: CLLocation, radius: CLLocationDistance) -> MKCoordinateRegion {
		let region = MKCoordinateRegion(center: location.coordinate,
										latitudinalMeters: radius,
										longitudinalMeters: radius)
		return region
	}
}

extension RestaurantsMapViewController: MKMapViewDelegate {
	private func showRestaurantsOnMap() {
		guard let restaurantsList, let map = mapView?.mapView else { return }
		removeAnnotations(from: map)
		addAnotations(on: map, from: restaurantsList)
	}
	private func removeAnnotations(from map: MKMapView) {
		map.removeAnnotations(map.annotations)
	}
	private func addAnotations(on map: MKMapView, from restaurantsList: [MKMapItem]) {
		for restaurant in restaurantsList {
			let annotation = MKPointAnnotation()
			annotation.coordinate = restaurant.placemark.coordinate
			annotation.title = restaurant.name
			map.addAnnotation(annotation)
		}
	}
}
