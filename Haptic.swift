//
//  Haptic.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 18/12/2021.
//

import Foundation
import UIKit

public class Haptic {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
