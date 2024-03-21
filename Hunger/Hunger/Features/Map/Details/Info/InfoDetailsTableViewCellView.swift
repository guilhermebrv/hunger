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
	let starImageView = UIImageView()
	let ratingLabel = UILabel()
	let openedLabel = UILabel()

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

extension InfoDetailsTableViewCellView {
	private func createElements() {
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		nameLabel.textColor = .label
		nameLabel.numberOfLines = 0
	}
	private func addElements() {
		addSubview(nameLabel)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
			nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
		])
	}
}

