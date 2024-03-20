//
//  SearchRestaurantView.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit
import MapKit

class SearchRestaurantView: UIView {
	let mapView = MKMapView()
	let searchTableView = UITableView(frame: .zero, style: .grouped)

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
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.mapType = .standard
		mapView.isZoomEnabled = false
		mapView.isScrollEnabled = false
		mapView.showsUserLocation = true
		mapView.isUserInteractionEnabled = true
		mapView.layer.cornerRadius = 8
		if #available(iOS 13.0, *) {
			mapView.pointOfInterestFilter = .excludingAll
		}

		searchTableView.translatesAutoresizingMaskIntoConstraints = false
		searchTableView.backgroundColor = .secondarySystemBackground
		searchTableView.showsVerticalScrollIndicator = false
		searchTableView.register(DistanceSliderTableViewCell.self,
								 forCellReuseIdentifier: DistanceSliderTableViewCell.identifier)
		searchTableView.register(TypeSelectionTableViewCell.self,
								 forCellReuseIdentifier: TypeSelectionTableViewCell.identifier)
		searchTableView.register(SearchTableViewCell.self,
								 forCellReuseIdentifier: SearchTableViewCell.identifier)
		searchTableView.allowsSelection = false
		searchTableView.separatorStyle = .none
	}
	private func addElements() {
		addSubview(mapView)
		addSubview(searchTableView)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
			mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 2),
			mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),

			searchTableView.topAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 1),
			searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
