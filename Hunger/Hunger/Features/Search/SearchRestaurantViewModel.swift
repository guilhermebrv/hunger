//
//  SearchRestaurantViewModel.swift
//  Hunger
//
//  Created by Guilherme Viana on 15/03/2024.
//

import UIKit

struct SearchRestaurantViewModel {
	private var cellTypes: [[SearchTableViewCellType]] = [[.distance], [.restaurant, .search]]

	// MARK: Table View Methods
	public func numberOfRowsInSection(in section: Int) -> Int {
		cellTypes[section].count
	}
	public var numberOfSections: Int {
		cellTypes.count
	}
	public func getTableViewCell(for tableView: UITableView, index: IndexPath) -> UITableViewCell {
		switch cellTypes[index.section][index.row] {
		case .distance:
			let cell = tableView.dequeueReusableCell(withIdentifier: DistanceSliderTableViewCell.identifier,
													 for: index) as? DistanceSliderTableViewCell
			return cell ?? UITableViewCell()
		case .restaurant:
			let cell = tableView.dequeueReusableCell(withIdentifier: TypeSelectionTableViewCell.identifier,
													 for: index) as? TypeSelectionTableViewCell
			return cell ?? UITableViewCell()
		case .search:
			let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
													 for: index) as? SearchTableViewCell
			return cell ?? UITableViewCell()
		}
	}
	public func titleForHeaderInSection(in section: Int) -> String {
		switch section {
		case 0:
			"DISTANCE"
		case 1:
			"FOOD TYPE"
		default:
			String()
		}
	}
	public func heightForHeaderInSection(in section: Int) -> CGFloat {
		switch section {
		case 0:
			CGFloat(30)
		case 1:
			CGFloat(20)
		case 2:
			CGFloat(0)
		default:
			CGFloat(0)
		}
	}
	public func heightForRowAt(index: IndexPath) -> CGFloat {
		switch cellTypes[index.section][index.row] {
		case .distance:
			90
		case .restaurant:
			430
		case .search:
			70
		}
	}
}
