//
//  EventManager.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 17/10/24.
//

import Foundation

class EventManager {
    // Dictionary to store events by date in the format "yyyy-MM-dd"
    private var eventsByDate: [String: [CalendarEvent]] = [:]
    
    // Singleton pattern to share one instance of EventManager across the app
    static let shared = EventManager()
    
    private init() {} // Prevent external instantiation
    
    // MARK: - Add Events
    
    /// Adds events from an external source (web service or database)
    /// - Parameter events: The list of events to add
    func addEvents(_ events: [CalendarEvent]) {
        for event in events {
            addEvent(event)
        }
    }
    
    /// Adds a single event to the events dictionary
    /// - Parameter event: The event to add
    private func addEvent(_ event: CalendarEvent) {
        let dateStr = event.date // Assumes dateString is formatted as "yyyy-MM-dd"
        
        // Append the event to the existing list for the date, or create a new list if none exists
        if var existingEvents = eventsByDate[dateStr] {
            existingEvents.append(event)
            eventsByDate[dateStr] = existingEvents
        } else {
            eventsByDate[dateStr] = [event]
        }
    }
    
    // MARK: - Get Events
    
    /// Retrieves events for a specific date
    /// - Parameter date: The date for which to retrieve events
    /// - Returns: An array of CalendarEvent objects for the given date, or nil if no events exist
    func getEvents(for date: Date) -> [CalendarEvent]? {
        let dateStr = formatDate(date)
        return eventsByDate[dateStr]
    }
    
    // MARK: - Clear Events
    
    /// Clears all stored events
    func clearAllEvents() {
        eventsByDate.removeAll()
    }
    
    // MARK: - Set Events in CalendarView
    
    /// Loads events into the provided CalendarView
    /// - Parameter calendarView: The CalendarView instance to update
    func setEventsInCalendar(_ calendarView: CalendarView) {
        calendarView.loadEvents(eventsByDate: eventsByDate)
    }
    
    // MARK: - Utility Methods
    
    /// Formats a Date object to a string in "yyyy-MM-dd" format
    /// - Parameter date: The date to format
    /// - Returns: A formatted date string
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // MARK: - Load Events from JSON File
    
    /// Loads events from a JSON file in the app bundle
    /// - Parameter fileName: The name of the JSON file (without the extension)
    func loadEventsFromJSON(fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let eventsData = try decoder.decode(Events.self, from: data)
            
            for (date, eventsArray) in eventsData.eventsByDate {
                for event in eventsArray {
                    let calendarEvent = CalendarEvent(eventID: event.eventID, title: event.title, date: date, eventType: event.eventType)
                    addEvent(calendarEvent)
                }
            }
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
}
