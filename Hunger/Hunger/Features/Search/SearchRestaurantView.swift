//
//  SearchRestaurantView.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import MapKit

protocol SearchRestaurantViewDelegate: AnyObject {
	func searchButtonClicked()
	func sliderValueChanged(value: Int)
}

class SearchRestaurantView: UIView {
	weak var delegate: SearchRestaurantViewDelegate?
	let restaurantsTableView = UITableView()
	let mapsButton = UIButton(type: .system)
	let radiusSlider = InstantSlider()
	let radiusLabel = UILabel()
	let mapView = MKMapView()

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

extension SearchRestaurantView {
	private func createElements() {
		// TODO: REFACTOR TO PUT ONLY RELEVANT PROPERTIES
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.mapType = .standard
		mapView.isZoomEnabled = true
		mapView.isScrollEnabled = true
		mapView.showsUserLocation = true
		mapView.showsCompass = true
		mapView.showsScale = true
		mapView.showsTraffic = true
		mapView.showsBuildings = true
		mapView.isUserInteractionEnabled = true
		mapView.isPitchEnabled = true
		mapView.layer.cornerRadius = 8

		radiusSlider.translatesAutoresizingMaskIntoConstraints = false
		radiusSlider.minimumValue = 1
		radiusSlider.maximumValue = 60
		radiusSlider.value = 25
		radiusSlider.isContinuous = true
		radiusSlider.tintColor = .systemBlue
		radiusSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

		radiusLabel.translatesAutoresizingMaskIntoConstraints = false
		radiusLabel.text = "\(Int(radiusSlider.value * 50))m"

		mapsButton.translatesAutoresizingMaskIntoConstraints = false
		mapsButton.configuration = .bordered()
		mapsButton.configuration?.title = "Results"
		mapsButton.configuration?.baseBackgroundColor = .systemBlue
		mapsButton.configuration?.baseForegroundColor = .systemBackground
		mapsButton.configuration?.cornerStyle = .capsule
		mapsButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
	}
	private func addElements() {
		addSubview(mapView)
		addSubview(radiusSlider)
		addSubview(radiusLabel)
		addSubview(mapsButton)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
			mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 2),
			mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),

			radiusSlider.topAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 2),
			radiusSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			trailingAnchor.constraint(equalTo: radiusSlider.trailingAnchor, constant: 20),

			radiusLabel.topAnchor.constraint(equalToSystemSpacingBelow: radiusSlider.bottomAnchor, multiplier: 2),
			radiusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			mapsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
			mapsButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

extension SearchRestaurantView {
	@objc private func searchButtonClicked() {
		delegate?.searchButtonClicked()
	}
	@objc private func sliderValueChanged() {
		delegate?.sliderValueChanged(value: Int(radiusSlider.value))
	}
}

