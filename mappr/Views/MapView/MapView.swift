//
//  EventMapView.swift
//  mappr
//
//  Created by Hashim Khan on 10/17/25.
//

import SwiftUI
import MapKit

struct EventMapView: View {
    @StateObject private var viewModel = EventViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            // Use our custom clean map wrapper (no POIs or icons)
            CleanMapView(region: $viewModel.region, events: viewModel.events)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.addMockEvents()
                }
            
            // Refresh button
            Button(action: {
                viewModel.addMockEvents()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(10)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .padding()
        }
    }
}

#Preview {
    EventMapView()
}

