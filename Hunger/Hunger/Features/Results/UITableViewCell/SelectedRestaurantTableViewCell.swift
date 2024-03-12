//
//  RestaurantResultsTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

class SelectedRestaurantTableViewCell: UITableViewCell {
	private let view = SelectedRestaurantTableViewCellView()
	static let identifier = String(describing: SelectedRestaurantTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(view)
		view.pin(to: self)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
