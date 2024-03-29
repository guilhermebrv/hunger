//
//  RestaurantDetailsView.swift
//  Hunger
//
//  Created by Guilherme Viana on 21/03/2024.
//

import UIKit
import MapKit

class RestaurantDetailsView: UIView {
	let detailsTableView = UITableView(frame: .zero, style: .grouped)

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .systemBackground
		createElements()
		addElements()
		configConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RestaurantDetailsView {
	private func createElements() {
		detailsTableView.translatesAutoresizingMaskIntoConstraints = false
		detailsTableView.backgroundColor = .secondarySystemBackground
		detailsTableView.showsVerticalScrollIndicator = false
		detailsTableView.register(InfoDetailsTableViewCell.self, forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
		detailsTableView.register(AddressDetailsTableViewCell.self, forCellReuseIdentifier: AddressDetailsTableViewCell.identifier)
		detailsTableView.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier)
		detailsTableView.allowsSelection = false
		detailsTableView.separatorStyle = .none
		detailsTableView.backgroundColor = .systemBackground
	}

	private func addElements() {
		addSubview(detailsTableView)

	}

	private func configConstraints() {
		NSLayoutConstraint.activate([
			detailsTableView.topAnchor.constraint(equalTo: topAnchor),
			detailsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			detailsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			detailsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}


