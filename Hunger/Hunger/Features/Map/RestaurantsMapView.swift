//
//  RestaurantsMapView.swift
//  Hunger
//
//  Created by Guilherme Viana on 18/03/2024.
//

import UIKit
import MapKit

class RestaurantsMapView: UIView {
	let mapView = MKMapView()
	var userTrackingButton = MKUserTrackingButton(mapView: MKMapView())

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

extension RestaurantsMapView {
	private func createElements() {
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.mapType = .standard
		mapView.isZoomEnabled = true
		mapView.isScrollEnabled = true
		mapView.showsUserLocation = true
		mapView.showsCompass = false
		mapView.showsBuildings = true
		mapView.userTrackingMode = .followWithHeading
		mapView.isUserInteractionEnabled = true
		mapView.layer.cornerRadius = 8

		userTrackingButton = MKUserTrackingButton(mapView: mapView)
		userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
		userTrackingButton.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
		userTrackingButton.clipsToBounds = true
		userTrackingButton.layer.cornerRadius = 5
	}
	private func addElements() {
		addSubview(mapView)
		addSubview(userTrackingButton)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: topAnchor),
			mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: bottomAnchor),

			userTrackingButton.topAnchor.constraint(equalToSystemSpacingBelow: mapView.topAnchor, multiplier: 2),
			mapView.trailingAnchor.constraint(equalToSystemSpacingAfter: userTrackingButton.trailingAnchor, multiplier: 2),
		])
	}
}
