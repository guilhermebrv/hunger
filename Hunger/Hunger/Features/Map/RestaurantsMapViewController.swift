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
	let restaurantsList: [MKMapItem]

	init(locationManager: CLLocationManager, radiusDistance: CLLocationDistance, restaurantsList: [MKMapItem]) {
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
		for restaurant in restaurantsList {
			let annotation = MKPointAnnotation()
			annotation.coordinate = restaurant.placemark.coordinate
			annotation.title = restaurant.name
			map.addAnnotation(annotation)
		}
	}
}
