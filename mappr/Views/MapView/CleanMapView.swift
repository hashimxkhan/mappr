//
//  CleanMapView.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//

import SwiftUI
import MapKit

struct CleanMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var events: [Event]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        // Clean base map — no POIs or clutter
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsBuildings = false
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsTraffic = false
        mapView.showsUserLocation = false
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false

        mapView.setRegion(region, animated: false)
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)

        for event in events {
            mapView.addAnnotation(EventAnnotation(event: event))
        }

        mapView.setRegion(region, animated: false)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CleanMapView
        init(_ parent: CleanMapView) { self.parent = parent }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let eventAnn = annotation as? EventAnnotation else { return nil }

            let reuseID = "CirclePin"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                view?.canShowCallout = false
            } else {
                view?.annotation = annotation
            }

            // ---- Build circular pin image ----
            let color = UIColor(eventAnn.event.pinColor ?? .blue)
            let baseSize: CGFloat = 14
            let maxSize: CGFloat = 28
            let normalized = min(1.0, CGFloat(eventAnn.event.attendees) / 200.0)
            let size = baseSize + (maxSize - baseSize) * normalized

            // Draw a colored circle into a UIImage
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
            let image = renderer.image { context in
                let rect = CGRect(x: 0, y: 0, width: size, height: size)
                context.cgContext.setFillColor(color.cgColor)
                context.cgContext.fillEllipse(in: rect)
                context.cgContext.setStrokeColor(UIColor.white.cgColor)
                context.cgContext.setLineWidth(2)
                context.cgContext.strokeEllipse(in: rect.insetBy(dx: 1, dy: 1))
            }

            view?.image = image
            view?.centerOffset = CGPoint(x: 0, y: -size / 2.5)
            view?.layer.shadowColor = UIColor.black.cgColor
            view?.layer.shadowOpacity = 0.3
            view?.layer.shadowRadius = 2
            view?.layer.shadowOffset = CGSize(width: 0, height: 1)
            // ---------------------------------

            return view
        }
    }
}

// MARK: - Annotation + Color Extension
class EventAnnotation: NSObject, MKAnnotation {
    let event: Event
    var coordinate: CLLocationCoordinate2D { event.coordinate }
    var title: String? { event.title }

    init(event: Event) { self.event = event }
}

extension Event {
    var pinColor: Color? {
        switch category.lowercased() {
        case "party": return .red
        case "club": return .blue
        case "study": return .green
        case "concert": return .purple
        default: return .gray
        }
    }
}

