//
//  TypeSelectionCollectionViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 14/03/2024.
//

import UIKit

class TypeSelectionCollectionViewCell: UICollectionViewCell {
	var button: UIButton!
	static let identifier = String(describing: TypeSelectionCollectionViewCell.self)

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .secondarySystemBackground
		button = UIButton(type: .system)
		button.frame = self.contentView.bounds
		button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.addSubview(button)
		button.pin(to: contentView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
