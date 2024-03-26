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
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		if let customAnnotation = view.annotation as? CustomAnnotation {
			mapView.deselectAnnotation(customAnnotation, animated: false)
			presentRestaurantDetails(restaurant: customAnnotation)
		}
	}
	func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
		if let cluster = annotation as? MKClusterAnnotation {
			return configClusterView(map: mapView, annotation: cluster)
		} else if let customAnnotation = annotation as? CustomAnnotation {
			return configMarkerView(map: mapView, annotation: customAnnotation)
		}
		return nil
	}
	private func configClusterView(map: MKMapView, annotation cluster: MKClusterAnnotation) -> MKMarkerAnnotationView {
		let identifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
		var clusterView = map.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

		if clusterView == nil {
			clusterView = MKMarkerAnnotationView(annotation: cluster, reuseIdentifier: identifier)
		}
		clusterView?.annotation = cluster
		clusterView?.markerTintColor = .systemOrange
		clusterView?.glyphTintColor = .secondarySystemBackground
		clusterView?.glyphText = String(cluster.memberAnnotations.count)

		return clusterView ?? MKMarkerAnnotationView()
	}
	private func configMarkerView(map: MKMapView, annotation: CustomAnnotation) -> MKMarkerAnnotationView {
		let identifier = "CustomAnnotation"
		var markerView = map.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

		if markerView == nil {
			markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			markerView?.canShowCallout = true
		} else {
			markerView?.annotation = annotation
		}

		markerView?.clusteringIdentifier = "cluster"
		if let markerView = markerView { designMarkerView(for: markerView, annotation: annotation) }

		return markerView ?? MKMarkerAnnotationView()
	}
	private func designMarkerView(for marker: MKMarkerAnnotationView, annotation: CustomAnnotation) {
		marker.glyphTintColor = .secondarySystemBackground
		marker.markerTintColor = .systemOrange

		switch annotation.category {
		case "Cafe", "Bakery":
			marker.glyphImage = UIImage(systemName: "cup.and.saucer.fill")
		default:
			marker.glyphImage = UIImage(systemName: "fork.knife")
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

extension RestaurantsMapViewController {
	func presentRestaurantDetails(restaurant: CustomAnnotation) {
		let restaurantDetails = RestaurantDetailsViewController(selectedItem: restaurant)
		restaurantDetails.modalPresentationStyle = .pageSheet
		restaurantDetails.sheetPresentationController?.prefersGrabberVisible = true
		restaurantDetails.sheetPresentationController?.detents = [.medium(), .large()]
		present(restaurantDetails, animated: true)
	}
}
