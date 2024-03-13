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
	var locationManager: CLLocationManager!
	var userSelectedRadius: CLLocationDistance = 250


	override func loadView() {
		super.loadView()
		searchView = SearchRestaurantView()
		view = searchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		setupLocationManager()
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

extension SearchRestaurantViewController: SearchRestaurantViewDelegate {
//	func sliderValueChanged(value: Int) {
//		let multipliedValue = value * 50
//		searchView?.radiusLabel.text = "\(multipliedValue) m"
//		userSelectedRadius = CLLocationDistance(multipliedValue)
//		locationManager.startUpdatingLocation()
//	}
	
	func searchButtonClicked() {
		let restResultsVC = RestaurantResultsViewController()
		navigationController?.pushViewController(restResultsVC, animated: true)
	}
}

extension SearchRestaurantViewController: CLLocationManagerDelegate {
	private func setupLocationManager() {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			let region = MKCoordinateRegion(center: center, latitudinalMeters: userSelectedRadius * 2, longitudinalMeters: userSelectedRadius * 2)
			searchView?.mapView.setRegion(region, animated: true)
			locationManager.stopUpdatingLocation()
		}
	}
	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		// TODO: implement error retrieving the location function
	}
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			locationManager.startUpdatingLocation()
		}
	}
}

extension SearchRestaurantViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DistanceSliderTableViewCell.identifier,
												 for: indexPath) as? DistanceSliderTableViewCell
		cell?.delegate = self
		return cell ?? UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 90
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
			case 0:
				return "DISTANCE"
			case 1:
				return "Second Section"
			default:
				return nil
			}
	}
}

extension SearchRestaurantViewController {
	private func signProtocols() {
		searchView?.delegate = self
		searchView?.searchTableView.delegate = self
		searchView?.searchTableView.dataSource = self
	}
}

extension SearchRestaurantViewController: DistanceSliderTableViewCellDelegate {
	func sliderValueChanged(value: Int) {
		let multipliedValue = value * 50
		userSelectedRadius = CLLocationDistance(multipliedValue)
		locationManager.startUpdatingLocation()
	}
}

