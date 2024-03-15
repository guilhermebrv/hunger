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
	var searchView: SearchRestaurantView?
	var distanceCell: DistanceSliderTableViewCell?
	var locationManager: CLLocationManager?
	var userSelectedRadius: CLLocationDistance = 1250
	var cellTypes: [[SearchTableViewCellType]] = [[.distance], [.restaurant, .search]]

	override func loadView() {
		super.loadView()
		searchView = SearchRestaurantView()
		view = searchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		setupLocationManager()
		deliveryOverlay()
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
			let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			let region = MKCoordinateRegion(center: center, latitudinalMeters: userSelectedRadius * 2,
											longitudinalMeters: userSelectedRadius * 2)

			DispatchQueue.main.async {
				self.searchView?.mapView.setRegion(region, animated: true)
			}
			//locationManager?.stopUpdatingLocation()
		}
	}
	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		// TODO: implement error retrieving the location function
	}
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch locationManager?.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			DispatchQueue.main.async {
				self.locationManager?.startUpdatingLocation()
			}
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
	func deliveryOverlay() {
		guard let location = locationManager?.location else { return }
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let circle = MKCircle(center: center, radius: userSelectedRadius)
		searchView?.mapView.addOverlay(circle)
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

	private func showPlacesOnMap() {
		guard let map = searchView?.mapView else { return }
		map.removeAnnotations(map.annotations)

		guard let location = locationManager?.location else { return }
		let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: userSelectedRadius/2,
										longitudinalMeters: userSelectedRadius/2)

		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = "taco"
		request.region = region

		var resultsList: [MKLocalSearch.Response] = []

		let search = MKLocalSearch(request: request)
		search.start { response, error in
			guard let response else { return } // handle error
			resultsList.append(response)
			print(resultsList)
			for item in response.mapItems {
				let annotation = MKPointAnnotation()
				annotation.coordinate = item.placemark.coordinate
				annotation.title = item.name
				map.addAnnotation(annotation)
			}
		}
	}
}

extension SearchRestaurantViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		cellTypes[section].count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch cellTypes[indexPath.section][indexPath.row] {
		case .distance:
			let cell = tableView.dequeueReusableCell(withIdentifier: DistanceSliderTableViewCell.identifier,
													 for: indexPath) as? DistanceSliderTableViewCell
			cell?.delegate = self
			return cell ?? UITableViewCell()
		case .restaurant:
			let cell = tableView.dequeueReusableCell(withIdentifier: TypeSelectionTableViewCell.identifier,
													 for: indexPath) as? TypeSelectionTableViewCell
			return cell ?? UITableViewCell()
		case .search:
			let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
													 for: indexPath) as? SearchTableViewCell
			cell?.delegate = self
			return cell ?? UITableViewCell()
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch cellTypes[indexPath.section][indexPath.row] {
		case .distance:
			90
		case .restaurant:
			430
		case .search:
			70
		}
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			"DISTANCE"
		case 1:
			"FOOD TYPE"
		default:
			nil
		}
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch section {
		case 0:
			return CGFloat(30)
		case 1:
			return CGFloat(20)
		case 2:
			return CGFloat(0)
		default:
			return CGFloat(0)
		}
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		cellTypes.count
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
		showPlacesOnMap()
	}
}

