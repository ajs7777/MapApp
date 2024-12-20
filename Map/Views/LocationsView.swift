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
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
