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
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0.0){
                header
                    .padding(8)
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(radius: 10)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    }
                }
            }
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
                Text(vm.mapLocation.name + "," + vm.mapLocation.cityName)
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
}
