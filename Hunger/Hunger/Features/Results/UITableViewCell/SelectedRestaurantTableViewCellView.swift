//
//  RestaurantResultsTableViewCellView.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

class SelectedRestaurantTableViewCellView: UIView {

//	let restaurantImageView = UIImageView()
	let infoStackView = UIStackView()
	let nameLabel = UILabel()
	let typeLabel = UILabel()
	let priceRangeLabel = UILabel()
	let distanceLabel = UILabel()
	let starImageView = UIImageView()
	let ratingLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		createElements()
		addElements()
		configConstraints()
		backgroundColor = .tertiarySystemBackground
		layer.cornerRadius = 8
		clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SelectedRestaurantTableViewCellView {
	private func createElements() {
//		restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
//		restaurantImageView.contentMode = .scaleAspectFill
//		restaurantImageView.clipsToBounds = true
//		restaurantImageView.layer.cornerRadius = 8
//		restaurantImageView.image = UIImage(systemName: "photo")?.
//		withRenderingMode(.alwaysOriginal).withTintColor(.systemGray5)

		infoStackView.translatesAutoresizingMaskIntoConstraints = false
		infoStackView.axis = .vertical
		infoStackView.spacing = 3
		infoStackView.alignment = .leading

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 0

		typeLabel.translatesAutoresizingMaskIntoConstraints = false
		typeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		typeLabel.textColor = .secondaryLabel

		priceRangeLabel.translatesAutoresizingMaskIntoConstraints = false
		priceRangeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		priceRangeLabel.textColor = .tertiaryLabel
		priceRangeLabel.text = "$$"

		distanceLabel.translatesAutoresizingMaskIntoConstraints = false
		distanceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		distanceLabel.textColor = .secondaryLabel

		starImageView.translatesAutoresizingMaskIntoConstraints = false
		starImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
		starImageView.contentMode = .scaleAspectFit
		starImageView.tintColor = .systemYellow

		ratingLabel.translatesAutoresizingMaskIntoConstraints = false
		ratingLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		ratingLabel.textColor = .secondaryLabel
		ratingLabel.text = "4.3"
	}

	private func addElements() {
//		addSubview(restaurantImageView)
		addSubview(infoStackView)
		infoStackView.addArrangedSubview(nameLabel)
		infoStackView.addArrangedSubview(typeLabel)
		infoStackView.addArrangedSubview(priceRangeLabel)
		addSubview(distanceLabel)
		addSubview(starImageView)
		addSubview(ratingLabel)
	}

	private func configConstraints() {
		NSLayoutConstraint.activate([
//			restaurantImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//			restaurantImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
//			restaurantImageView.widthAnchor.constraint(equalToConstant: 150),
//			restaurantImageView.heightAnchor.constraint(equalToConstant: 100),

			infoStackView.topAnchor.constraint(equalToSystemSpacingBelow: starImageView.bottomAnchor, multiplier: 1),
			infoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			infoStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: infoStackView.trailingAnchor, multiplier: 2),

			bottomAnchor.constraint(equalToSystemSpacingBelow: distanceLabel.bottomAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: distanceLabel.trailingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: ratingLabel.trailingAnchor, multiplier: 2),

			starImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
			starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
			ratingLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: starImageView.trailingAnchor, multiplier: 0.5)
		])
	}
}
