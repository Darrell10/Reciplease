//
//  Int.swift
//  Reciplease
//
//  Created by Frederick Port on 02/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation

extension Int {
    /// Convert the minutes to display in string format
    var convertTimeToString: String {
        if self == 0 {
            let timeNull = "No time Added"
            return timeNull
        } else {
            let minutes = self % 60
            let hours = self / 60
            let timeFormatString = String(hours) + " h " + String(minutes) + " min"
            let timeFormatStringMin = String(minutes) + " min"
            if self >= 60 {
                return timeFormatString
            } else {
                return timeFormatStringMin
            }
        }
    }
}

