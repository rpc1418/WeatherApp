//
//  AddEditLoc.swift
//  WeatherApp
//
//  Created by rentamac on 30/01/2026.
//

import SwiftUI

struct AddEditLoc: View {
    @Binding var name: String
    @Binding var latitude: Double?
    @Binding var longitude: Double?
    @Binding var showAddNewLocation: Bool
    @Binding var dummyLocationForUpdate: Location?
    var listViewModel: ListViewModel
    @Binding var forEdit: Bool
    
    var body: some View {
        
        VStack(alignment: .leading){
            if listViewModel.isLoading {
                Text("Loading...")
                    .font(.system(size: 50))
                    .foregroundStyle(Color("foregroundColor"))
                Spacer()
            } else {
                if listViewModel.errorMessage != nil {
                    Text(listViewModel.errorMessage ?? "")
                        .font(.system(size: 20))
                        .foregroundStyle(Color("foregroundColor"))
                        .padding()
                }
                
                TextField(
                    "Name Field",
                    text: $name,
                    prompt: Text("Name of the Location")
                        .foregroundColor(Color.foreground)  // change color here
                )
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .foregroundStyle(Color("foregroundColor")) // text color
                .background(Color.background)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("foregroundColor"), lineWidth: 2)
            )
                .padding(.horizontal)
                .padding(.top)

                if(forEdit){
                    Text("Latitude:")
                        .foregroundStyle(Color.foreground)
                        .padding(.horizontal,25)
                        
                    TextField(
                        "Latitude Field",
                        value: $latitude,
                        formatter: {
                            let f = NumberFormatter()
                            f.numberStyle = .decimal
                            f.maximumFractionDigits = 6
                            f.minimumFractionDigits = 0
                            f.allowsFloats = true
                            return f
                        }(),
                        prompt: Text("Latitude of the location")
                            .foregroundColor(Color("foregroundColor")) // placeholder color
                    )
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .foregroundStyle(Color("foregroundColor")) // text color
                    .background(Color("backgroundColor"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("foregroundColor"), lineWidth: 2) // border
                    )
                    .padding(.horizontal)

                    Text("Longitude:")
                        .foregroundStyle(Color.foreground)
                        .padding(.horizontal,25)
                    TextField(
                        "Longitude Field",
                        value: $longitude,
                        formatter: {
                            let f = NumberFormatter()
                            f.numberStyle = .decimal
                            f.maximumFractionDigits = 6
                            f.minimumFractionDigits = 0
                            f.allowsFloats = true
                            return f
                        }(),
                        prompt: Text("Longitude of the location")
                            .foregroundColor(Color("foregroundColor")) // placeholder color
                    )
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .foregroundStyle(Color("foregroundColor")) // text color
                    .background(Color("backgroundColor"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("foregroundColor"), lineWidth: 2) // border
                    )
                    .padding(.horizontal)
}
            Button(
                action: {
//                                print("for edit \(forEdit)")
                    guard !name.isEmpty else {
                        return
                    }
                    
                    if forEdit {
                        listViewModel.updateLocation(
                            location: dummyLocationForUpdate!,
                            name: name,
                            latitude: latitude ?? 0.0,
                            longitude: longitude ?? 0.0
                        )
                        forEdit = false
                        showAddNewLocation=false
                        name = ""
                        latitude = nil
                        longitude = nil
                    } else{
                        Task{
                            let n=name
                            let added=await listViewModel.fetchLatLong(name: n)
                            print("after fetch ")
                            forEdit = false
                            showAddNewLocation = !added
                            name = ""
                            latitude = nil
                            longitude = nil
                        }
                        
                    }
                    
                    
                }
            ) {
                Text(forEdit ? "Update Location" : "Add Location")
                    .font(Font.headline.bold())
                           .frame(height: 55)
                           .frame(maxWidth: .infinity)
                           .foregroundStyle(.white)
                           .background(.blue)
                           .clipShape(RoundedRectangle(cornerRadius: 10))

            }
            
            .padding()
            .padding(.bottom)
            .transition(
                .move(edge: showAddNewLocation ? .bottom : .top)
            )
            .zIndex(1)
        }
                
    }

     
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("backgroundColor"))
                .shadow(color: .foreground.opacity(0.9), radius: 50, x: 0, y: 10)
        )
        
        .padding(.bottom,-35)
    }
}


