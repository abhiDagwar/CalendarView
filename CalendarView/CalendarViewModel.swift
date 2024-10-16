//
//  CalendarViewModel.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 09/10/24.
//

import Foundation

struct CalendarEvent: Decodable {
    let eventID: Int
    let title: String
    let date: String
    let eventType: String
}

class CalendarViewModel {
    var events: [CalendarEvent] = []
    
    func loadEvents() {
        if let path = Bundle.main.path(forResource: "Events", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([String: [CalendarEvent]].self, from: data)
                if let events = decodedData["events"] {
                    self.events = events
                }
            } catch {
                print("Error loading or decoding JSON: \(error)")
            }
        }
    }
    
    // Method to set events from an external source, like a ViewController
    func setEvents(_ events: [CalendarEvent]) {
        self.events = events
    }
    
    // Method to get an event for a specific date
    func eventForDate(_ date: String) -> CalendarEvent? {
        return events.first { $0.date == date }
    }
}
