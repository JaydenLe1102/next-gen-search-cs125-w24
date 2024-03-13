//
//  Utils.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/11/24.
//

import Foundation


class Utils{
    
    static func convertSecondsToHours(seconds: Double) -> Double{
        return seconds / 3600
    }
    
    static func convertSecondsToHoursMinutes(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600  // Get whole hours
        let remainingSeconds = Int(seconds) % 3600
        let minutes = remainingSeconds / 60  // Get remaining minutes

        return "\(hours)h \(minutes)m"
    }

    
}
