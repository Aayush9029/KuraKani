//
//  Defaults+Extensions.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Defaults
import SwiftUI

extension Defaults.Keys {
    static let haptic = Key<Bool>("HAPTIC_FEEDBACK", default: true)
    static let crashReport = Key<Bool>("SEND_CRASH_REPORT", default: false)
}
