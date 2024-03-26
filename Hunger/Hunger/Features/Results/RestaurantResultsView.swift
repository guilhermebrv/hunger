//
//  RestaurantResultsView.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

protocol RestaurantResultsViewDelegate: AnyObject {
	func tappedMapsButton()
}

class RestaurantResultsView: UIView {
	let restaurantsTableView = UITableView()
	let mapsButton = UIButton(type: .system)
	weak var delegate: RestaurantResultsViewDelegate?

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

extension RestaurantResultsView {
	private func createElements() {
		restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
		restaurantsTableView.backgroundColor = .secondarySystemBackground
		restaurantsTableView.showsVerticalScrollIndicator = false
		restaurantsTableView.separatorStyle = .none
		restaurantsTableView.allowsSelection = false
		restaurantsTableView.register(SelectedRestaurantTableViewCell.self,
									  forCellReuseIdentifier: SelectedRestaurantTableViewCell.identifier)
		restaurantsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)


		mapsButton.translatesAutoresizingMaskIntoConstraints = false
		mapsButton.configuration = .bordered()
		mapsButton.configuration?.title = "Open Maps"
		mapsButton.configuration?.baseBackgroundColor = .systemBlue
		mapsButton.configuration?.baseForegroundColor = .white
		mapsButton.configuration?.image = UIImage(systemName: "location.circle.fill")
		mapsButton.configuration?.imagePadding = 6
		mapsButton.configuration?.cornerStyle = .capsule
		mapsButton.addTarget(self, action: #selector(tappedMapsButton), for: .primaryActionTriggered)
	}
	private func addElements() {
		addSubview(restaurantsTableView)
		addSubview(mapsButton)

	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			restaurantsTableView.topAnchor.constraint(equalTo: topAnchor),
			restaurantsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			restaurantsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			restaurantsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

			mapsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
			mapsButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

extension RestaurantResultsView {
	@objc private func tappedMapsButton() {
		delegate?.tappedMapsButton()
	}
}

