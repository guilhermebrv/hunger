//
//  TypeSelectionCollectionViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 14/03/2024.
//

import UIKit

protocol TypeSelectionCollectionViewCellDelegate: AnyObject {
	func tappedTypeSelectionButton(in collection: TypeSelectionCollectionViewCell)
}

class TypeSelectionCollectionViewCell: UICollectionViewCell {
	weak var delegate: TypeSelectionCollectionViewCellDelegate?
	static let identifier = String(describing: TypeSelectionCollectionViewCell.self)
	var button: UIButton = UIButton(type: .system)

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .secondarySystemBackground
		setupButton()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TypeSelectionCollectionViewCell {
	private func setupButton() {
		contentView.addSubview(button)
		button.pin(to: contentView)
		button.frame = self.contentView.bounds
		button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		button.addTarget(self, action: #selector(tappedTypeSelectionButton), for: .primaryActionTriggered)
		button.isUserInteractionEnabled = true
		button.configuration = .gray()
		button.configuration?.cornerStyle = .capsule
	}
}

extension TypeSelectionCollectionViewCell {
	@objc func tappedTypeSelectionButton(sender: UIButton) {
		delegate?.tappedTypeSelectionButton(in: self)
	}
}
