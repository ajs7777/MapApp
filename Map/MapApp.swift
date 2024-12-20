//
//  MapApp.swift
//  Map
//
//  Created by Abhijit Saha on 20/12/24.
//

import SwiftUI

@main
struct MapApp: App {
    
    @StateObject var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(LocationsViewModel())
        }
    }
}
