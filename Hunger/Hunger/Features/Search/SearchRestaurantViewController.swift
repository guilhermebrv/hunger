//
//  SearchRestaurantViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import CoreLocation
import MapKit

class SearchRestaurantViewController: UIViewController {
	let viewModel: SearchRestaurantViewModel = SearchRestaurantViewModel()
	var searchView: SearchRestaurantView?
	var locationManager: CLLocationManager?
	var userSelectedRadius: CLLocationDistance = 1250
	var circleOverlay: MKCircle?

	override func loadView() {
		super.loadView()
		searchView = SearchRestaurantView()
		view = searchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupLocationManager()
		signProtocols()
		setMapOverlay(radius: userSelectedRadius)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = "Search"
		navigationItem.titleView?.tintColor = .label
		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = .secondarySystemBackground

		let blurEffect = UIBlurEffect(style: .regular)
		let blurView = UIVisualEffectView(effect: blurEffect)
		blurView.frame = self.navigationController?.navigationBar.bounds ?? CGRect.zero
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

		appearance.backgroundEffect = blurEffect
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.isTranslucent = true
	}
}

extension SearchRestaurantViewController {
	private func signProtocols() {
		searchView?.mapView.delegate = self
		searchView?.searchTableView.delegate = self
		searchView?.searchTableView.dataSource = self
	}
}

extension SearchRestaurantViewController: DistanceSliderTableViewCellDelegate, SearchTableViewCellDelegate {
	func tappedSearchButton() {
		let restResultsVC = RestaurantResultsViewController()
		navigationController?.pushViewController(restResultsVC, animated: true)
	}
	func sliderValueChanged(value: Int) {
		let multipliedValue = value * 50
		userSelectedRadius = CLLocationDistance(multipliedValue)
		locationManager?.startUpdatingLocation()
		setMapOverlay(radius: userSelectedRadius)
		//showPlacesOnMap()
	}
}

extension SearchRestaurantViewController: CLLocationManagerDelegate {
	private func setupLocationManager() {
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		locationManager?.requestWhenInUseAuthorization()
		locationManager?.startUpdatingLocation()
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			let region = setRegion(radius: userSelectedRadius * 2.5)
			
			DispatchQueue.main.async { self.searchView?.mapView.setRegion(region, animated: true) }
			setMapOverlay(radius: userSelectedRadius)
			//locationManager?.stopUpdatingLocation()
		}
	}
	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		// TODO: implement error retrieving the location function
	}
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch locationManager?.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			DispatchQueue.main.async { self.locationManager?.startUpdatingLocation() }
		case .denied:
			print() // HANDLE
		case .notDetermined, .restricted:
			print() // HANDLE
		default:
			print() // HANDLE
		}
	}
}

extension SearchRestaurantViewController: MKMapViewDelegate {
	func setMapOverlay(radius: CLLocationDistance) {
		removeOverlay()
		guard let location = locationManager?.location else { return }
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		circleOverlay = MKCircle(center: center, radius: radius)
		searchView?.mapView.addOverlay(circleOverlay ?? MKCircle())
	}
	func removeOverlay() {
		guard let circleOverlay else { return }
		searchView?.mapView.removeOverlay(circleOverlay)
	}

	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay.isKind(of: MKCircle.self){
			let circleRenderer = MKCircleRenderer(overlay: overlay)
			circleRenderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.1)
			circleRenderer.strokeColor = UIColor.systemBlue
			circleRenderer.lineWidth = 1
			return circleRenderer
		}
		return MKOverlayRenderer(overlay: overlay)
	}
	// MARK: FUNCTIONS TO SHOW ANNOTATIONS ON MAP
//	private func showPlacesOnMap() {
//		guard let map = searchView?.mapView else { return }
//		guard let location = locationManager?.location else { return }
//
//		removeAnnotations(from: map)
//		let region = setRegion(radius: userSelectedRadius)
//
//		let request = MKLocalSearch.Request()
//		request.naturalLanguageQuery = "taco"
//		request.region = region
//
//		let search = MKLocalSearch(request: request)
//		search.start { response, error in
//			guard let response else { return } // handle error
//			let filteredItems = self.radiusFilter(from: response)
//			DispatchQueue.main.async { self.addAnotations(on: map, from: filteredItems) }
//		}
//	}
//	private func removeAnnotations(from map: MKMapView) {
//		map.removeAnnotations(map.annotations)
//	}
	private func setRegion(radius: CLLocationDistance) -> MKCoordinateRegion {
		guard let location = locationManager?.location else { return MKCoordinateRegion() }
		let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius,
										longitudinalMeters: radius)
		return region
	}
//	private func radiusFilter(from response: MKLocalSearch.Response) -> [MKMapItem] {
//		guard let location = locationManager?.location else { return [MKMapItem]() }
//		let centerLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//		let filteredItems = response.mapItems.filter { item in
//			let itemLocation = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
//			return centerLocation.distance(from: itemLocation) <= self.userSelectedRadius
//		}
//		return filteredItems
//	}
//	private func addAnotations(on map: MKMapView, from filteredItems: [MKMapItem]) {
//		for item in filteredItems {
//			let annotation = MKPointAnnotation()
//			annotation.coordinate = item.placemark.coordinate
//			annotation.title = item.name
//			map.addAnnotation(annotation)
//		}
//	}
}

extension SearchRestaurantViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection(in: section)
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.numberOfSections
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = viewModel.getTableViewCell(for: tableView, index: indexPath)
		switch cell {
		case let distanceCell as DistanceSliderTableViewCell:
			distanceCell.delegate = self
		// case let typeCell as TypeSelectionTableViewCell:
		//	typeCell.delegate = self
		case let searchCell as SearchTableViewCell:
			searchCell.delegate = self
		default:
			break
		}
		return cell
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.titleForHeaderInSection(in: section)
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		viewModel.heightForHeaderInSection(in: section)
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt(index: indexPath)
	}
}
