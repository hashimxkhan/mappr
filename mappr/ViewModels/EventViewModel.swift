//
//  EventViewModel.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//

import Foundation
import Combine
import MapKit

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.4237, longitude: -86.9212), // Purdue by default
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
  //  private let service = FirebaseService()
    
    func fetchEvents() {
   //     service.fetchEvents { [weak self] fetchedEvents in
   //         DispatchQueue.main.async {
   //             self?.events = fetchedEvents
     //       }
    //    }
    }
    
    func addMockEvents() {
        events = [
            Event(title: "Club Callout", description: "Join us for our first callout!", category: "Club",
                  date: Date(), latitude: 40.424, longitude: -86.921, locationName: "WALC", attendees: 250),
            Event(title: "House Party", description: "DJ + snacks!", category: "Party",
                  date: Date(), latitude: 40.423, longitude: -86.922, locationName: "Chauncey", attendees: 2)
        ]
    }
}
