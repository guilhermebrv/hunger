//
//  RestaurantDetailsViewModel.swift
//  Hunger
//
//  Created by Guilherme Viana on 27/03/2024.
//

import UIKit

struct RestaurantDetailsViewModel {
	private var cellTypes: [RestaurantDetailsTableViewCellType] = [.info, .route, .address]

	public var numberOfRowsInSection: Int {
		cellTypes.count
	}

	public func heightForRowAt(for index: IndexPath) -> CGFloat {
		switch cellTypes[index.row] {
		case .info:
			110
		case .route:
			90
		case .address:
			100
		}
	}

	public func getTableViewCell(for tableView: UITableView, index: IndexPath) -> UITableViewCell {
		switch cellTypes[index.row] {
		case .info:
			let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailsTableViewCell.identifier, 
													 for: index) as? InfoDetailsTableViewCell
			return cell ?? UITableViewCell()
		case .route:
			let cell = tableView.dequeueReusableCell(withIdentifier: RouteTableViewCell.identifier,
													 for: index) as? RouteTableViewCell
			return cell ?? UITableViewCell()
		case .address:
			let cell = tableView.dequeueReusableCell(withIdentifier: AddressDetailsTableViewCell.identifier,
													 for: index) as? AddressDetailsTableViewCell
			return cell ?? UITableViewCell()
		}
	}
}
