//
//  RestaurantsMapView.swift
//  Hunger
//
//  Created by Guilherme Viana on 18/03/2024.
//

import UIKit
import MapKit

protocol RestaurantsMapViewDelegate: AnyObject {
	func didTapCloseButton()
}

class RestaurantsMapView: UIView {
	let mapView = MKMapView()
	var userTrackingButton = MKUserTrackingButton(mapView: MKMapView())
	let closeButton = UIButton(frame: CGRect(x: 16, y: 16, width: 45, height: 45))
	weak var delegate: RestaurantsMapViewDelegate?

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
		if #available(iOS 13.0, *) {
			mapView.pointOfInterestFilter = .excludingAll
		}

		userTrackingButton = MKUserTrackingButton(mapView: mapView)
		userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
		userTrackingButton.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
		userTrackingButton.clipsToBounds = false
		userTrackingButton.layer.cornerRadius = 5
		userTrackingButton.layer.cornerRadius = 5
		userTrackingButton.layer.shadowOpacity = 0.5
		userTrackingButton.layer.shadowOffset = CGSize(width: 1, height: 1)

		closeButton.backgroundColor = .secondarySystemBackground
		closeButton.setTitle("X", for: .normal)
		closeButton.setTitleColor(.systemBlue, for: .normal)
		closeButton.layer.cornerRadius = 5
		closeButton.layer.shadowOpacity = 0.5
		closeButton.layer.shadowOffset = CGSize(width: 1, height: 1)
		closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
	}
	private func addElements() {
		addSubview(mapView)
		mapView.addSubview(userTrackingButton)
		mapView.addSubview(closeButton)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: topAnchor),
			mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: bottomAnchor),

			userTrackingButton.topAnchor.constraint(equalToSystemSpacingBelow: mapView.topAnchor, multiplier: 2),
			mapView.trailingAnchor.constraint(equalToSystemSpacingAfter: userTrackingButton.trailingAnchor, multiplier: 2)
		])
	}
}

extension RestaurantsMapView {
	@objc func didTapCloseButton() {
		delegate?.didTapCloseButton()
	}
}
