//
//  RestaurantResultsTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import MapKit

class SelectedRestaurantTableViewCell: UITableViewCell {
	private let view = SelectedRestaurantTableViewCellView()
	static let identifier = String(describing: SelectedRestaurantTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
		backgroundColor = .secondarySystemBackground
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SelectedRestaurantTableViewCell {
	private func setupLayout() {
		contentView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
			view.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 2),
			view.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	public func configureCell(with restaurant: MKMapItem, type: String, distance: Int) {
		view.nameLabel.text = restaurant.name
		view.typeLabel.text = type
		view.distanceLabel.text = "\(distance)m"
	}
}
