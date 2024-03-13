//
//  InstantSlider.swift
//  Hunger
//
//  Created by Guilherme Viana on 13/03/2024.
//

import UIKit

class InstantSlider: UISlider {
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let width = self.frame.size.width
		let tapPoint = touch.location(in: self)
		let value = self.minimumValue + Float(tapPoint.x / width) * (self.maximumValue - self.minimumValue)

		self.setValue(value, animated: true)
		return super.beginTracking(touch, with: event)
	}

}
