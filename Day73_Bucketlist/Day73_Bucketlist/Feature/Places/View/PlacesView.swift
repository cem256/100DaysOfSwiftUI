//
//  PlacesView.swift
//  Day73_Bucketlist
//
//  Created by cem on 13.08.2023.
//

import SwiftUI
import MapKit

struct PlacesView: View {
    @StateObject private var placesViewModel = PlacesViewModel()
    
    var body: some View {
        if placesViewModel.authenticationStatus == .authenticated {
            ZStack {
                Map(coordinateRegion: $placesViewModel.mapRegion, annotationItems: placesViewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            placesViewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            placesViewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                        
                    }
                }
            }
            .sheet(item: $placesViewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    placesViewModel.update(location: newLocation)
                }
            }
        } else if placesViewModel.authenticationStatus == .initial || placesViewModel.authenticationStatus  == .failed  {
            VStack {
                Button("Unlock Places") {
                    placesViewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                if placesViewModel.authenticationStatus == .failed {
                    Text("Authentication failed try again")
                    
                }
            }
        }
        else if placesViewModel.authenticationStatus == .noBiometrics {
            Text("Your phone does not have biometric authentication methods")
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
