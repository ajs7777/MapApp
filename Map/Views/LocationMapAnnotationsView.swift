//
//  LocationMapAnnotationsView.swift
//  Map
//
//  Created by Abhijit Saha on 23/12/24.
//

import SwiftUI

struct LocationMapAnnotationsView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0.0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundStyle(accentColor)
                .rotationEffect(.degrees(180))
                .offset(y: -4)
        }.padding(.bottom, 40)
    }
}

#Preview {
    LocationMapAnnotationsView()
}
