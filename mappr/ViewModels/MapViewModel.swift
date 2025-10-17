//
//  MapViewModel.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = EventViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.events) { event in
                MapAnnotation(coordinate: event.coordinate) {
                    VStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                        Text(event.title)
                            .font(.caption2)
                            .foregroundColor(.black)
                    }
                }
            }
            .ignoresSafeArea()
            
            Button(action: {
                viewModel.addMockEvents()   // replace with fetchEvents() after Firebase setup
            }) {
                Image(systemName: "arrow.clockwise")
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            .padding()
        }
    }
}
