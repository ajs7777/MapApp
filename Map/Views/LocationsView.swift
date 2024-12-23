//
//  LocationsView.swift
//  Map
//
//  Created by Abhijit Saha on 20/12/24.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLyer
                .ignoresSafeArea()
            VStack(spacing: 0.0){
                header
                    .padding(8)
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .animation(.none, value: vm.locations)
                    .foregroundStyle(.primary)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .overlay(alignment: .leading, content: {
                        Image(systemName:  "arrow.down")
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 0 : -180))
                            .foregroundStyle(.primary)
                            .font(.headline)
                            .padding()
                    })
            }
            
            if vm.showLocationList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
    }
    
    private var mapLyer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationsView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.5)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .shadow(radius: 10)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}
