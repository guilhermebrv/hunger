//
//  InfoDetailsTableViewCellView.swift
//  Hunger
//
//  Created by Guilherme Viana on 21/03/2024.
//

import UIKit

class InfoDetailsTableViewCellView: UIView {
	let nameLabel = UILabel()
	let typeLabel = UILabel()
	let priceLabel = UILabel()
	let distanceLabel = UILabel()
	// let starImageView = UIImageView()
	// let ratingLabel = UILabel()
	let ballOpenedLabel = UILabel()
	let openedLabel = UILabel()

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

extension InfoDetailsTableViewCellView {
	private func createElements() {
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 0

		distanceLabel.translatesAutoresizingMaskIntoConstraints = false
		distanceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		distanceLabel.textColor = .tertiaryLabel

		ballOpenedLabel.translatesAutoresizingMaskIntoConstraints = false
		ballOpenedLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		ballOpenedLabel.textColor = .systemGreen
		ballOpenedLabel.text = "●"

		openedLabel.translatesAutoresizingMaskIntoConstraints = false
		openedLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		openedLabel.textColor = .secondaryLabel
		openedLabel.text = "Opened"

		typeLabel.translatesAutoresizingMaskIntoConstraints = false
		typeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		typeLabel.textColor = .secondaryLabel

		priceLabel.translatesAutoresizingMaskIntoConstraints = false
		priceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		priceLabel.textColor = .tertiaryLabel
		priceLabel.text = "$$"
	}
	private func addElements() {
		addSubview(nameLabel)
		addSubview(distanceLabel)
		addSubview(ballOpenedLabel)
		addSubview(openedLabel)
		addSubview(typeLabel)
		addSubview(priceLabel)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
			nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),

			distanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			trailingAnchor.constraint(equalToSystemSpacingAfter: distanceLabel.trailingAnchor, multiplier: 2),

			ballOpenedLabel.centerYAnchor.constraint(equalTo: openedLabel.centerYAnchor),
			openedLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: ballOpenedLabel.trailingAnchor, multiplier: 0.5),

			openedLabel.topAnchor.constraint(equalToSystemSpacingBelow: distanceLabel.bottomAnchor, multiplier: 2),
			openedLabel.trailingAnchor.constraint(equalTo: distanceLabel.trailingAnchor),

			typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
			typeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

			priceLabel.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
			priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
		])
	}
}

