//
//  AddressDetailsTableViewCellView.swift
//  Hunger
//
//  Created by Guilherme Viana on 27/03/2024.
//

import UIKit

class AddressDetailsTableViewCellView: UIView {
	let addressLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		createElements()
		addElements()
		configConstraints()
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = 8
		clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AddressDetailsTableViewCellView {
	private func createElements() {
		addressLabel.translatesAutoresizingMaskIntoConstraints = false
		addressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		addressLabel.textColor = .secondaryLabel
		addressLabel.numberOfLines = 0
	}
	
	private func addElements() {
		addSubview(addressLabel)
	}

	private func configConstraints() {
		NSLayoutConstraint.activate([
			addressLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
			addressLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: addressLabel.trailingAnchor, multiplier: 2),
			bottomAnchor.constraint(equalToSystemSpacingBelow: addressLabel.bottomAnchor, multiplier: 1)
		])
	}
}
