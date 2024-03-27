//
//  RestaurantDetailsViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 20/03/2024.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController {
	private var detailsView: RestaurantDetailsView?
	private let viewModel: RestaurantDetailsViewModel = RestaurantDetailsViewModel()
	private let locationManager: CLLocationManager
	private let selectedItem: CustomAnnotation

	init(selectedItem: CustomAnnotation, locationManager: CLLocationManager) {
		self.selectedItem = selectedItem
		self.locationManager = locationManager
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		detailsView = RestaurantDetailsView()
		view = detailsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		signProtocols()
	}
}

extension RestaurantDetailsViewController {
	private func signProtocols() {
		detailsView?.detailsTableView.delegate = self
		detailsView?.detailsTableView.dataSource = self
	}
}

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = viewModel.getTableViewCell(for: tableView, index: indexPath)
		switch cell {
		case let infoCell as InfoDetailsTableViewCell:
			infoCell.setupCell(locationManager: locationManager, item: selectedItem)
		default:
			break
		}
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
}
