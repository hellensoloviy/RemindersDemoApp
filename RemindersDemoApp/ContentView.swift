//
//  ContentView.swift
//  RemindersDemoApp
//
//  Created by Olena Solovii on 4/13/21.
//

import SwiftUI
import EventKit
import EventKitUI

struct ContentView: View {
    let eventStore = EKEventStore()
          
    let reminderText = "Some text here"

    var body: some View {
        
        VStack() {
            Text("Hello, world!")
                .padding()
            Text("This is an app for testing of how to set reminders.")
                .lineLimit(4)
                .padding()
            Button("Set Reminder") {
                setReminder()
            }
            Spacer()
        }.frame(width: 300, height: 200, alignment: .center)
        
    }
    
    func setReminder() {
        
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
         granted, error in
         if (granted) && (error == nil) {
           print("granted \(granted)")


           let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
           reminder.title = "Must do this!"
           reminder.priority = 2

           //  How to show completed
            reminder.completionDate = Date().addingTimeInterval(15)

            reminder.notes = "...this is a note :)"

           let alarmTime = Date().addingTimeInterval(1)
           let alarm = EKAlarm(absoluteDate: alarmTime)
           reminder.addAlarm(alarm)

           reminder.calendar = self.eventStore.defaultCalendarForNewReminders()

           do {
             try self.eventStore.save(reminder, commit: true)
           } catch {
             print("Cannot save")
             return
           }
           print("Reminder saved")
         }
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
