//
//  TypeSelectionCollectionViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 14/03/2024.
//

import UIKit

class TypeSelectionCollectionViewCell: UICollectionViewCell {
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
		button.addTarget(self, action: #selector(tappedButton), for: .primaryActionTriggered)
		button.isUserInteractionEnabled = true
		button.configuration = .gray()
		button.configuration?.cornerStyle = .capsule
	}
	@objc func tappedButton(_ sender: UIButton) {
		print(sender.titleLabel?.text ?? "")
	}
}
