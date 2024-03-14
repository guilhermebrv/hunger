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
}

class SearchRestaurantView: UIView {
	weak var delegate: SearchRestaurantViewDelegate?
	let mapView = MKMapView()
	let searchTableView = UITableView(frame: .zero, style: .grouped)
	let mapsButton = UIButton(type: .system)

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
		// mapView.showsCompass = true
		// mapView.showsScale = true
		// mapView.showsTraffic = true
		//mapView.showsBuildings = true
		mapView.isUserInteractionEnabled = true
		mapView.layer.cornerRadius = 8

		searchTableView.translatesAutoresizingMaskIntoConstraints = false
		searchTableView.backgroundColor = .secondarySystemBackground
		searchTableView.showsVerticalScrollIndicator = false
		searchTableView.register(DistanceSliderTableViewCell.self, forCellReuseIdentifier: DistanceSliderTableViewCell.identifier)
		searchTableView.register(TypeSelectionTableViewCell.self, forCellReuseIdentifier: TypeSelectionTableViewCell.identifier)
		searchTableView.allowsSelection = false
		searchTableView.separatorStyle = .none

		mapsButton.translatesAutoresizingMaskIntoConstraints = false
		mapsButton.configuration = .bordered()
		mapsButton.configuration?.title = "Results"
		mapsButton.configuration?.baseBackgroundColor = .systemBlue
		mapsButton.configuration?.baseForegroundColor = .white
		mapsButton.configuration?.cornerStyle = .capsule
		mapsButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
	}
	private func addElements() {
		addSubview(mapView)
		addSubview(searchTableView)
		addSubview(mapsButton)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
			mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 2),
			mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),

			searchTableView.topAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 1),
			searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

			mapsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
			mapsButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

extension SearchRestaurantView {
	@objc private func searchButtonClicked() {
		delegate?.searchButtonClicked()
	}
}

