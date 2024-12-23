//
//  LocationPreviewView.swift
//  Map
//
//  Created by Abhijit Saha on 22/12/24.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm : LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 20.0) {
                imageSection
                titleSection
            }
            Spacer()
            
            VStack{
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 50)
        )
        .cornerRadius(10)
        .padding()
        
    }
}

#Preview {
    ZStack {
        Color.green
            .ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
    
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
        }
    }
}

extension LocationPreviewView {
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
    }
}

extension LocationPreviewView {
    private var learnMoreButton: some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn More")
                .fontWeight(.semibold)
                .frame(width: 120, height: 30)
        } .buttonStyle(BorderedProminentButtonStyle())
    }
}

extension LocationPreviewView {
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .fontWeight(.semibold)
                .frame(width: 120, height: 30)
        } .buttonStyle(BorderedButtonStyle())
            
    }
}
