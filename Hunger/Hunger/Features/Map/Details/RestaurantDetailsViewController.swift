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
		case let addressCell as AddressDetailsTableViewCell:
			addressCell.delegate = self
			addressCell.setupCell(item: selectedItem.item)
		default:
			break
		}
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt(for: indexPath)
	}
}

extension RestaurantDetailsViewController: AddressDetailsTableViewCellDelegate {
	func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
		if gesture.state == .began {
			let point = gesture.location(in: detailsView?.detailsTableView)
			if let indexPath = detailsView?.detailsTableView.indexPathForRow(at: point),
			   let cell = detailsView?.detailsTableView.cellForRow(at: indexPath) as? AddressDetailsTableViewCell {

				let addressLabel = cell.contentView.viewWithTag(13) as? UILabel
				UIPasteboard.general.string = addressLabel?.text

				cell.view.backgroundColor = UIColor.systemGray3
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					cell.view.backgroundColor = .secondarySystemBackground
				}
			}
		}
	}
}
