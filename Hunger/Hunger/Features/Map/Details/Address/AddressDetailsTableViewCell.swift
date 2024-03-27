//
//  AddressDetailsTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 27/03/2024.
//

import UIKit
import MapKit

class AddressDetailsTableViewCell: UITableViewCell {
	let view = AddressDetailsTableViewCellView()
	static let identifier = String(describing: AddressDetailsTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
		backgroundColor = .systemBackground
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AddressDetailsTableViewCell {
	private func setupLayout() {
		contentView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 2),
			view.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	public func setupCell(item: MKMapItem) {
		let placemark = item.placemark

		let streetNumber = placemark.subThoroughfare ?? ""
		let streetName = placemark.thoroughfare ?? ""
		let city = placemark.locality ?? ""
		let state = placemark.administrativeArea ?? ""
		let postalCode = placemark.postalCode ?? ""
		let country = placemark.country ?? ""

		view.addressLabel.text = "\(streetNumber) \(streetName) \n\(city), \(state), \(country) \n\(postalCode)"
	}
}

