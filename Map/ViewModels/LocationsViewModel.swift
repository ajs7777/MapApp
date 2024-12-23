//
//  LocationsViewModel.swift
//  Map
//
//  Created by Abhijit Saha on 20/12/24.
//
import SwiftUI
import Foundation
import MapKit

class LocationsViewModel: ObservableObject {
    
    @Published var locations : [Location]
    @Published var mapLocation : Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var showLocationList = false
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan =  MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: mapLocation)
    }
    
    func updateMapRegion(location : Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        mapLocation = location
        showLocationList = false
    }
    
    func nextButtonPressed() {
        guard let firstIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print( "Couldn't find mapLocation in locations")
            return
        }
        let nextIndex = firstIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    
    //    func nextButtonPressed() {
    //        // Find the index of the current mapLocation in the locations list
    //        if let currentIndex = locations.firstIndex(where: { $0.id == mapLocation.id }) {
    //            // Calculate the next index, cycling back to 0 if we reach the end
    //            let nextIndex = (currentIndex + 1) % locations.count
    //            // Set the next location as the map location
    //            mapLocation = locations[nextIndex]
    //        }
    //    }
}
