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
}
