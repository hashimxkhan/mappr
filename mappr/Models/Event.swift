//
//  Event.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//

import Foundation
import CoreLocation

struct Event: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var category: String
    var date: Date
    var latitude: Double
    var longitude: Double
    var locationName: String
    var attendees: Int
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
