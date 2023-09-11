//
//  DateFormatters.swift
//  Itinerary
//
//  Created by Alex on 8/3/23.
//

import Foundation

func formatDay(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd"
    return dateFormatter.string(from: date)
}

func formatMonth(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: date)
}

func formatDayMonth(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    return dateFormatter.string(from: date)
}
