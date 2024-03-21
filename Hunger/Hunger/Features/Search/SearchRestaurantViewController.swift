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
	var userSelectedRadius: CLLocationDistance = 1500
	var circleOverlay: MKCircle?
	var previousSelectedButton: UIButton?
	var previousTypeTitleLabel: String?
	var selectedType: String?
	var buttonEnabled: Bool = false

	override func loadView() {
		super.loadView()
		searchView = SearchRestaurantView()
		view = searchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupLocationManager()
		signProtocols()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		configureNavBar(title: "Search")
	}
}

extension SearchRestaurantViewController {
	private func signProtocols() {
		searchView?.mapView.delegate = self
		searchView?.searchTableView.delegate = self
		searchView?.searchTableView.dataSource = self
	}
	private func makeNewSelection(cell: TypeSelectionCollectionViewCell) {
		if let previousButton = previousSelectedButton, let previousTitle = previousTypeTitleLabel {
			var oldConfig = previousButton.configuration ?? .gray()
			oldConfig = .gray()
			oldConfig.cornerStyle = .capsule
			oldConfig.title = previousTitle
			previousButton.configuration = oldConfig
		}
		cell.button.configuration = .filled()
		cell.button.configuration?.cornerStyle = .capsule
		previousSelectedButton = cell.button
		previousTypeTitleLabel = cell.button.currentTitle
	}
}

extension SearchRestaurantViewController: DistanceSliderTableViewCellDelegate, SearchTableViewCellDelegate {
	func sliderValueChanged(value: Int) {
		userSelectedRadius = CLLocationDistance(value)
		// locationManager?.startUpdatingLocation()
		setMapOverlay(radius: userSelectedRadius)
	}
	func tappedSearchButton() {
		if let locationManager, let selectedType {
			let restResultsVC = RestaurantResultsViewController(locationManager: locationManager,
																radiusDistance: userSelectedRadius,
																foodType: selectedType)
			navigationController?.pushViewController(restResultsVC, animated: true)
		}
	}
}

extension SearchRestaurantViewController: CLLocationManagerDelegate {
	private func setupLocationManager() {
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.requestWhenInUseAuthorization()
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		// locationManager?.startUpdatingLocation()
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			DispatchQueue.main.async {
				let region = self.setRegion(for: location, radius: self.userSelectedRadius * 2.5)
				self.searchView?.mapView.setRegion(region, animated: true)
				self.setMapOverlay(radius: self.userSelectedRadius)
			}
		}
	}
	private func setRegion(for location: CLLocation, radius: CLLocationDistance) -> MKCoordinateRegion {
		let region = MKCoordinateRegion(center: location.coordinate,
										latitudinalMeters: radius,
										longitudinalMeters: radius)
		return region
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
		if let circleOverlay { searchView?.mapView.removeOverlay(circleOverlay) }
		guard let location = locationManager?.location else { return }
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		circleOverlay = MKCircle(center: center, radius: radius)
		searchView?.mapView.addOverlay(circleOverlay ?? MKCircle())
	}
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay.isKind(of: MKCircle.self) {
			let circleRenderer = MKCircleRenderer(overlay: overlay)
			circleRenderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.1)
			circleRenderer.strokeColor = UIColor.systemBlue
			circleRenderer.lineWidth = 1
			return circleRenderer
		}
		return MKOverlayRenderer(overlay: overlay)
	}
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
		case let typeCell as TypeSelectionTableViewCell:
			typeCell.callback = { collectionCell in
				self.makeNewSelection(cell: collectionCell)
				self.selectedType = collectionCell.button.currentTitle ?? ""
				self.buttonEnabled = true
				DispatchQueue.main.async { self.searchView?.searchTableView.reloadData() }
			}
		case let searchCell as SearchTableViewCell:
			searchCell.delegate = self
			if self.buttonEnabled { searchCell.view.searchButton.isEnabled = true }
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
