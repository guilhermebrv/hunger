//
//  RestaurantResultsViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantResultsViewController: UIViewController, UINavigationBarDelegate {
	private var viewModel: RestaurantResultsViewModel = RestaurantResultsViewModel()
	var listView: RestaurantResultsView?
	
	let locationManager: CLLocationManager?
	let radiusDistance: CLLocationDistance?
	let foodType: String?

	init(locationManager: CLLocationManager, radiusDistance: CLLocationDistance, foodType: String) {
		self.locationManager = locationManager
		self.radiusDistance = radiusDistance
		self.foodType = foodType
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		listView = RestaurantResultsView()
		view = listView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		showRestaurantsList()
    }

//	let actionClosure = { (action: UIAction) in
//	}
//
//	public var orderByButton: UIButton {
//		let button = UIButton(primaryAction: nil)
//		var menuChildren: [UIMenuElement] = [UIAction(title: "Distance", handler: actionClosure),
//											 UIAction(title: "Ratings", handler: actionClosure)]
//
//		button.translatesAutoresizingMaskIntoConstraints = false
//		button.showsMenuAsPrimaryAction = true
//		button.changesSelectionAsPrimaryAction = true
//		button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
//		button.menu = UIMenu(options: .displayInline, children: menuChildren)
//		return button
//	}

	// REFACTOR
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureNavBar(title: "Restaurants")
		// navigationItem.rightBarButtonItem = UIBarButtonItem(customView: orderByButton)
	}

	@objc func togglePullDownMenu() {
	}
}

extension RestaurantResultsViewController {
	private func signProtocols() {
		listView?.restaurantsTableView.delegate = self
		listView?.restaurantsTableView.dataSource = self
	}
	private func distanceFromUser(restaurant: MKMapItem) -> Int {
		guard let currentLocation = locationManager?.location else { return 0 }
		let distanceInMeters = currentLocation.distance(from: restaurant.placemark.location ?? CLLocation())
		return Int(distanceInMeters)
	}
}

extension RestaurantResultsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let restaurants = viewModel.restaurantsList else { return UITableViewCell() }

		let cell = tableView.dequeueReusableCell(withIdentifier: SelectedRestaurantTableViewCell.identifier,
												 for: indexPath) as? SelectedRestaurantTableViewCell
		cell?.configureCell(with: restaurants[indexPath.row], 
							type: foodType ?? "",
							distance: distanceFromUser(restaurant: restaurants[indexPath.row]))
		return cell ?? UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
}

extension RestaurantResultsViewController {
		private func showRestaurantsList() {
			//guard let map = searchView?.mapView else { return }
			guard let location = locationManager?.location, let radiusDistance, let foodType else { return }

			//removeAnnotations(from: map)
			let region = setRegion(for: location, radius: radiusDistance)

			let request = MKLocalSearch.Request()
			request.naturalLanguageQuery = foodType
			request.region = region
	
			let search = MKLocalSearch(request: request)
			search.start { response, error in
				self.searchRestaurants(response, error)
				DispatchQueue.main.async {
					self.listView?.restaurantsTableView.reloadData()
				}
			}
		}
		private func setRegion(for location: CLLocation, radius: CLLocationDistance) -> MKCoordinateRegion {
			let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius,
											longitudinalMeters: radius)
			return region
		}
	private func searchRestaurants(_ response: MKLocalSearch.Response?, _ error: Error?) {
		guard let response else { return } // handle error
		let filteredItems = self.radiusFilter(from: response)
		self.viewModel.restaurantsList = filteredItems
		//DispatchQueue.main.async { self.addAnotations(on: map, from: filteredItems) }
	}
		private func radiusFilter(from response: MKLocalSearch.Response) -> [MKMapItem] {
			guard let location = locationManager?.location, let radiusDistance else { return [MKMapItem]() }
			let centerLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			let filteredItems = response.mapItems.filter { item in
				let itemLocation = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
				return centerLocation.distance(from: itemLocation) <= self.radiusDistance ?? 0
			}
			return filteredItems
		}
}

//		private func removeAnnotations(from map: MKMapView) {
//			map.removeAnnotations(map.annotations)
//		}

// private func addAnotations(on map: MKMapView, from filteredItems: [MKMapItem]) {
//			for item in filteredItems {
//				let annotation = MKPointAnnotation()
//				annotation.coordinate = item.placemark.coordinate
//				annotation.title = item.name
//				map.addAnnotation(annotation)
//			}
//		}
