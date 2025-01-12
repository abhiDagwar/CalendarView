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
        /// 1. ``calendar.component(.weekday, from: date)`` returns values from 1 (Sunday) to 7 (Saturday).
        /// 2. To shift the week so that Monday is the first day:
        ///     We add 7 to the original value to avoid negative numbers.
        ///     We take the result modulo 7, which wraps it around to the correct range.
        ///
        /// **The final mapping would look like this:**

        /// * - Sunday (1) becomes 0
        /// * - Monday (2) becomes 1
        /// * - Tuesday (3) becomes 2
        /// * - ...
        /// * - Saturday (7) becomes 6


        let weekday = calendar.component(.weekday, from: date)
        // Convert the weekday to a zero-based index: 0 for Sunday, 1 for Monday, etc.
        return (weekday + 7) % 7
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
    
    // MARK: - Function to add months with a custom offset (default is 1)
    func nextMonth(date: Date, by offset: Int = 1) -> Date {
        return calendar.date(byAdding: .month, value: offset, to: date)!
    }
    
    // MARK: - Function to subtract months with a custom offset (default is 1)
    func previousMonth(date: Date, by offset: Int = 1) -> Date {
        return calendar.date(byAdding: .month, value: -offset, to: date)!
    }
    
    // MARK: - Add this function to display a range of months (e.g.: if you want to display only current and previous month then add -1 to startMonth to display previous month and 0 to endMonth to hide next month.)
    func checkMonthAvailability(startMonth: Int, endMonth: Int, selectedDate: Date) -> (previousButtonEnabled: Bool, nextButtonEnabled: Bool) {
        let currentDate = Date()
        
        // Calculate the boundary months based on the input
        let startMonthDate = nextMonth(date: currentDate, by: startMonth)
        let endMonthDate = nextMonth(date: currentDate, by: endMonth)
        
        // Enable or disable the buttons based on whether the selected date is within the boundaries
        let previousMonthEnabled = selectedDate > startMonthDate
        let nextMonthEnabled = selectedDate < endMonthDate
        
        return (previousMonthEnabled, nextMonthEnabled)
    }
}
