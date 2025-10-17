//
//  FirebaseService.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//
//import Foundation
//import FirebaseFirestore
// import FirebaseFirestoreSwift
/*
class FirebaseService {
    private let db = Firestore.firestore()
    
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
       db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events: \(error)")
                completion([])
                return
            }
            
            let events = snapshot?.documents.compactMap { doc -> Event? in
                try? doc.data(as: Event.self)
            } ?? []
            
            completion(events)
        }
    }
    
    func addEvent(_ event: Event, completion: @escaping (Bool) -> Void) {
        do {
            try db.collection("events").document(event.id).setData(from: event)
            completion(true)
        } catch {
            print("Error adding event: \(error)")
            completion(false)
        }
    }
}
*/
