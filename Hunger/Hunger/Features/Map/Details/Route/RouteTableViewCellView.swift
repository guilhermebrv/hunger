//
//  RouteTableViewCellView.swift
//  Hunger
//
//  Created by Guilherme Viana on 27/03/2024.
//

import UIKit

protocol RouteTableViewCellViewDelegate: AnyObject {
	func tappedMapsButton()
	func tappedGoogleMapsButton()
}

class RouteTableViewCellView: UIView {
	weak var delegate: RouteTableViewCellViewDelegate?
	let stackView = UIStackView()
	let mapsButton = UIButton(type: .system)
	let googleMapsButton = UIButton(type: .system)

	override init(frame: CGRect) {
		super.init(frame: frame)
		createElements()
		addElements()
		configConstraints()
		backgroundColor = .systemBackground
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RouteTableViewCellView {
	private func createElements() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 8
		// stackView.alignment = .center

		mapsButton.translatesAutoresizingMaskIntoConstraints = false
		mapsButton.configuration = .filled()
		mapsButton.configuration?.title = "Open on Maps"
		mapsButton.configuration?.baseBackgroundColor = .systemBlue
		mapsButton.addTarget(self, action: #selector(tappedMapsButton), for: .touchUpInside)

		googleMapsButton.translatesAutoresizingMaskIntoConstraints = false
		googleMapsButton.configuration = .filled()
		googleMapsButton.configuration?.title = "Open on Google Maps"
		googleMapsButton.configuration?.baseBackgroundColor = .secondarySystemBackground
		googleMapsButton.addTarget(self, action: #selector(tappedGoogleMapsButton), for: .touchUpInside)
	}

	private func addElements() {
		addSubview(stackView)
		stackView.addArrangedSubview(mapsButton)
		stackView.addArrangedSubview(googleMapsButton)
	}

	private func configConstraints() {
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0.5),
			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
			trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
		])
	}
}

extension RouteTableViewCellView {
	@objc func tappedMapsButton() {
		delegate?.tappedMapsButton()
	}
	@objc func tappedGoogleMapsButton() {
		delegate?.tappedGoogleMapsButton()
	}
}
