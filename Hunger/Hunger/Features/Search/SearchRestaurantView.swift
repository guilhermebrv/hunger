//
//  SearchRestaurantView.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

protocol SearchRestaurantViewDelegate: AnyObject {
	func searchButtonClicked()
}

class SearchRestaurantView: UIView {
	let restaurantsTableView = UITableView()
	let mapsButton = UIButton(type: .system)
	weak var delegate: SearchRestaurantViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .red
		createElements()
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension SearchRestaurantView {
	private func createElements() {
		restaurantsTableView.translatesAutoresizingMaskIntoConstraints = false
		restaurantsTableView.backgroundColor = .systemBackground
		restaurantsTableView.showsVerticalScrollIndicator = false
		restaurantsTableView.register(SelectedRestaurantTableViewCell.self,
									  forCellReuseIdentifier: SelectedRestaurantTableViewCell.identifier)

		mapsButton.translatesAutoresizingMaskIntoConstraints = false
		mapsButton.configuration = .bordered()
		mapsButton.configuration?.title = "Results"
		mapsButton.configuration?.baseBackgroundColor = .systemBlue
		mapsButton.configuration?.baseForegroundColor = .systemBackground
		mapsButton.configuration?.cornerStyle = .capsule
		mapsButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
	}
	private func addElements() {
		addSubview(restaurantsTableView)
		addSubview(mapsButton)

	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			restaurantsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			restaurantsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			restaurantsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			restaurantsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

			mapsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
			mapsButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

extension SearchRestaurantView {
	@objc private func searchButtonClicked() {
		delegate?.searchButtonClicked()
	}
}

