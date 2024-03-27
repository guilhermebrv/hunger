//
//  RouteTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 27/03/2024.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

	let view = RouteTableViewCellView()
	static let identifier = String(describing: RouteTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(view)
		view.pin(to: contentView)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
