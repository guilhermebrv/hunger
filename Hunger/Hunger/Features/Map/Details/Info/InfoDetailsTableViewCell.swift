//
//  InfoDetailsTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 21/03/2024.
//

import UIKit
import MapKit

class InfoDetailsTableViewCell: UITableViewCell {
	let view = InfoDetailsTableViewCellView()
	static let identifier = String(describing: InfoDetailsTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(view)
		view.pin(to: contentView)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension InfoDetailsTableViewCell {
	public func setupCell(locationManager: CLLocationManager, item: CustomAnnotation) {
		let distance = locationManager.location?.distance(from: item.location)
		view.nameLabel.text = item.title
		view.typeLabel.text = item.category
		if let distance = distance {
			view.distanceLabel.text = "\(Int(distance))m"
		}
	}
}
