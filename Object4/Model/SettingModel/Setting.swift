//
//  Setting.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import Foundation
import SwiftData

@Model
final class AppSettings {
    var firstLaunch: Bool
    
    init(firstLaunch: Bool = true) {
        self.firstLaunch = firstLaunch
    }
}
