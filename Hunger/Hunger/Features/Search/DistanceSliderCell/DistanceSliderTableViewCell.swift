//
//  DistanceSliderTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 13/03/2024.
//

import UIKit

protocol DistanceSliderTableViewCellDelegate: AnyObject {
	func sliderValueChanged(value: Int)
}

class DistanceSliderTableViewCell: UITableViewCell {
	let view = DistanceSliderView()
	weak var delegate: DistanceSliderTableViewCellDelegate?
	static let identifier = String(describing: DistanceSliderTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .secondarySystemBackground
		contentView.addSubview(view)
		view.pin(to: contentView)
		view.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension DistanceSliderTableViewCell: DistanceSliderViewDelegate {
	func sliderValueChanged(value: Int) {
		let multipliedValue = value * 50
		view.radiusLabel.text = "Search for restaurants in a \(multipliedValue)m radius"
		delegate?.sliderValueChanged(value: value)
	}
}
