//
//  DistanceSliderView.swift
//  Hunger
//
//  Created by Guilherme Viana on 13/03/2024.
//

import UIKit

protocol DistanceSliderViewDelegate: AnyObject {
	func sliderValueChanged(value: Int)
}

class DistanceSliderView: UIView {
	weak var delegate: DistanceSliderViewDelegate?
	let bgview = UIView()
	let radiusSlider = InstantSlider()
	let radiusLabel = UILabel()

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

extension DistanceSliderView {
	private func createElements() {
		bgview.translatesAutoresizingMaskIntoConstraints = false
		bgview.backgroundColor = .tertiarySystemBackground
		bgview.layer.cornerRadius = 8

		// TODO: Fix slider values + slidervaluechanged on vc
		radiusSlider.translatesAutoresizingMaskIntoConstraints = false
		radiusSlider.isUserInteractionEnabled = true
		radiusSlider.minimumValue = 1
		radiusSlider.maximumValue = 60
		radiusSlider.value = 25
		radiusSlider.isContinuous = true
		radiusSlider.tintColor = .systemBlue
		radiusSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

		radiusLabel.translatesAutoresizingMaskIntoConstraints = false
		radiusLabel.text = "Search for restaurants in a \(Int(radiusSlider.value * 50))m radius"
		radiusLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		radiusLabel.textColor = .secondaryLabel
	}
	private func addElements() {
		addSubview(bgview)
		addSubview(radiusSlider)
		addSubview(radiusLabel)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			bgview.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
			bgview.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: bgview.trailingAnchor, multiplier: 2),
			bottomAnchor.constraint(equalToSystemSpacingBelow: bgview.bottomAnchor, multiplier: 1),


			radiusSlider.topAnchor.constraint(equalToSystemSpacingBelow: bgview.topAnchor, multiplier: 1),
			radiusSlider.leadingAnchor.constraint(equalToSystemSpacingAfter: bgview.leadingAnchor, multiplier: 2),
			bgview.trailingAnchor.constraint(equalToSystemSpacingAfter: radiusSlider.trailingAnchor, multiplier: 2),

			radiusLabel.topAnchor.constraint(equalToSystemSpacingBelow: radiusSlider.bottomAnchor, multiplier: 1),
			radiusLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: bgview.leadingAnchor, multiplier: 2),
			bgview.trailingAnchor.constraint(equalToSystemSpacingAfter: radiusLabel.trailingAnchor, multiplier: 2),
		])
	}
}

extension DistanceSliderView {
	@objc private func sliderValueChanged() {
		delegate?.sliderValueChanged(value: Int(radiusSlider.value))
	}
}
