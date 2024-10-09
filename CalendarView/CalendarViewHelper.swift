//
//  CalendarViewHelper.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 08/10/24.
//

import Foundation

class CalendarViewHelper {
    let calendar: Calendar = Calendar.current
    
    // MARK: - Get days in Month
    func daysInMonth(for date: Date) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: date) else {
            return 0
        }
        return range.count
    }
    
    // MARK: - First Day of Month
    func firstDayOfMonth(for date: Date) -> Date {
        calendar.startOfDay(for: date)
    }
        
    // MARK: - Weekday of the First Day in the Month
    func weekDay(date: Date) -> Int {
        return calendar.component(.weekday, from: date) - 1 // Sunday = 1, subtract 1 for 0-indexing
    }
    
    // MARK: - Get Month String
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Year String
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Day String
    func dayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Get Days in Week (Weekly View)
    func daysInWeek(date: Date) -> [Int?] {
        guard let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: date)?.start else {
            return []
        }
        var daysArray: [Int?] = []
        for i in 0..<7 {  // 7 days in a week
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                let dayInt = calendar.component(.day, from: day)
                daysArray.append(dayInt)
            } else {
                daysArray.append(nil)
            }
        }
        return daysArray
    }
    
    // MARK: - Create Date from Components
    func createDate(from day: String, monthNameString: String, yearString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set timezone to UTC
        let dateString = "\(day) \(monthNameString) \(yearString)"
        return dateFormatter.date(from: dateString)
    }
    
    //MARK: - Get the Date in String format
    func createFormattedDateString(from day: String, monthNameString: String, yearString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set timezone to UTC
        
        let dateString = "\(day) \(monthNameString) \(yearString)"
        
        // Convert string to Date object
        if let date = dateFormatter.date(from: dateString) {
            // Format Date object to "yyyy-MM-dd"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
