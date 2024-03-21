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

	let locationManager: CLLocationManager
	let radiusDistance: CLLocationDistance
	let foodType: String

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
		listView?.delegate = self
	}
}

extension RestaurantResultsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let restaurants = viewModel.restaurantsList,
				let location = locationManager.location else { return UITableViewCell() }

		let cell = tableView.dequeueReusableCell(withIdentifier: SelectedRestaurantTableViewCell.identifier,
												 for: indexPath) as? SelectedRestaurantTableViewCell
		cell?.configureCell(with: restaurants[indexPath.row],
							type: foodType,
							distance: viewModel.distanceFromUser(restaurants[indexPath.row], location))
		return cell ?? UITableViewCell()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
}

extension RestaurantResultsViewController {
	private func showRestaurantsList() {
		guard let location = locationManager.location else { return }

		let region = setRegion(for: location, radius: radiusDistance)

		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = foodType
		request.region = region

		let search = MKLocalSearch(request: request)
		search.start { [weak self] response, error in
			self?.searchRestaurants(response, error)
			DispatchQueue.main.async { self?.listView?.restaurantsTableView.reloadData() }
		}
	}
	private func setRegion(for location: CLLocation, radius: CLLocationDistance) -> MKCoordinateRegion {
		let region = MKCoordinateRegion(center: location.coordinate,
										latitudinalMeters: radius,
										longitudinalMeters: radius)
		return region
	}
	private func searchRestaurants(_ response: MKLocalSearch.Response?, _ error: Error?) {
		guard let response, let location = locationManager.location else { return } // handle error
		let filteredItems = self.viewModel.filterResultsRadius(from: response,
															   radius: radiusDistance,
															   location: location)
		self.viewModel.restaurantsList = filteredItems
	}
}

extension RestaurantResultsViewController: RestaurantResultsViewDelegate {
	func tappedMapsButton() {
		let modal = RestaurantsMapViewController(locationManager: locationManager, 
												 radiusDistance: radiusDistance,
												 foodType: foodType,
												 restaurantsList: viewModel.restaurantsList ?? [MKMapItem]())
		modal.modalPresentationStyle = .fullScreen
		present(modal, animated: true)
	}
}
