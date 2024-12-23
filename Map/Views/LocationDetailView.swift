//
//  LocationDetailView.swift
//  Map
//
//  Created by Abhijit Saha on 23/12/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(radius: 10)
                VStack(alignment: .leading){
                    textSection
                        
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
                                               
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var textSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
            
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text(location.description)
                .foregroundStyle(.secondary)
            
           if let url = URL(string: location.link) {
                Link("Read More", destination: url)
                   .foregroundStyle(.blue.opacity(0.8))
            }
        }
        
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationsView()
                    .shadow(radius: 30)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 10)
        }

    }
}
