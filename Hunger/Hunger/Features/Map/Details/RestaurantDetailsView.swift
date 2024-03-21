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
		detailsTableView.register(InfoDetailsTableViewCell.self,
								forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
		detailsTableView.allowsSelection = false
		detailsTableView.separatorStyle = .none
	}
	private func addElements() {
		addSubview(detailsTableView)

	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			detailsTableView.topAnchor.constraint(equalTo: topAnchor),
			detailsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			detailsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			detailsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

		])
	}
}


