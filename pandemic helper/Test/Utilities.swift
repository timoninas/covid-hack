//
//  Utilities.swift
//  test_h
//
//  Created by Mac-HOME on 04.05.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static let mySpacing: CGFloat = 30.0
    
    static func configureStackView(_ stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = mySpacing
    }
    
    static func styleInformationLabel(_ label: UILabel) {
        label.backgroundColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 30.0)
        label.layer.shadowOffset = .zero
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowRadius = 5
        label.numberOfLines = 0
    }
    
    static func styleHollowButton(_ button: UIButton) {
        button.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.setTitleColor(UIColor.black, for: .normal)
    }
    
    static func styleCardLabel(_ label: UILabel) {
        label.backgroundColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 30.0)
        label.layer.shadowOffset = .zero
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1
        label.numberOfLines = 0
    }
    
    static func animationPulseButton(_ button: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.98
        pulse.toValue = 1
        pulse.initialVelocity = 1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        button.layer.add(pulse, forKey: nil)
    }
    
    static func animationFlashLabel(_ label: UILabel) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        label.layer.add(flash, forKey: nil)
    }
}
