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
    
    static func convertSecondsToHoursMinutes(_ seconds: Double) -> (hours: Double, minutes: Double) {
      let hours = seconds / 3600  // Get hours with decimals
      let minutes = (seconds.truncatingRemainder(dividingBy: 3600) / 60).rounded(.toNearestOrAwayFromZero)  // Get minutes and round

      return (hours, minutes)
    }
    
}
