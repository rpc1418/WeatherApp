//
//  ListView.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import CoreData
import SwiftUI

struct ListView: View {

    @EnvironmentObject var router: AppRouter
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @State var showAddNewLocation: Bool = false
    @State var name: String = ""
    @State var latitude: Double? = nil
    @State var longitude: Double? = nil
    @State var forEdit: Bool = false
    @State var dummyLocationForUpdate: Location? = nil

    var body: some View {
        ZStack {

            Color("backgroundColor").ignoresSafeArea()
            VStack {

                List {
                    ForEach(listViewModel.filteredLocations) {
                        location in
                        Button(action: {
                            router.navigate(
                                to: .locationDetailView(location: location)
                            )
                        }) {
                            HStack {
                                Image(systemName: location.weather ?? "---")
                                                                                      .foregroundStyle(.yellow)
                                Text(location.name ?? "---")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(location.temperature ?? "---")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .listRowBackground(Color.clear)
                        .contextMenu {
                            Button {
                                dummyLocationForUpdate=location
                                name=location.name ?? ""
                                latitude=location.latitude as Double?
                                longitude=location.longitude as Double?
                                forEdit=true
                                showAddNewLocation=true
                            } label: {
                                Label(
                                    "Edit Location",
                                    systemImage: "pencil"
                                )
                            }

                            Button(role: .destructive) {
                                listViewModel.deleteByEntity(location: location)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                }
                .scrollContentBackground(.hidden)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            router.goBack()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .bold(true)
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 50)
                        }

                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showAddNewLocation.toggle()
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .bold(true)
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 50)
                                .rotationEffect(
                                    .degrees(showAddNewLocation ? 45 : 0)
                                )
                        }

                    }
                    ToolbarItem(placement: .principal) {
                        Text("Locations")
                            .foregroundStyle(.white)
                    }
                }
                ).searchable(
                    text: $listViewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search any location...!"
                )

                if showAddNewLocation {
                    VStack {
                        TextField("Name of the Location", text: $name)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 55)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        TextField(
                            "Latitude of the location",
                            value: $latitude,
                            formatter: {
                                let f = NumberFormatter()
                                f.numberStyle = .decimal
                                f.maximumFractionDigits = 6
                                f.minimumFractionDigits = 0
                                f.allowsFloats = true
                                return f
                            }()
                        )
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        TextField(
                            "Longitutde of the location",
                            value: $longitude,
                            formatter: {
                                let f = NumberFormatter()
                                f.numberStyle = .decimal
                                f.maximumFractionDigits = 6
                                f.minimumFractionDigits = 0
                                f.allowsFloats = true
                                return f
                            }()
                        )
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        Button(
                            action: {
                                print("for edit \(forEdit)")
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
                                } else{
                                    listViewModel.addLocation(
                                        name: name,
                                        latitude: latitude ?? 0.0,
                                        longitude: longitude ?? 0.0
                                    )
                                }
                                
                                forEdit = false
                                showAddNewLocation=false
                                name = ""
                                latitude = nil
                                longitude = nil
                            }
                        ) {
                            Text(forEdit ? "Update Location" : "Add Location")
                                .font(Font.headline.bold())
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .background(.blue)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .transition(
                            .move(edge: showAddNewLocation ? .bottom : .top)
                        )
                        .zIndex(1)
                    }
                } else {
                    HStack(spacing: 20){
                        Button("Load famous Locations coordinates") {
                            listViewModel.addTestLocations()
                        }
                        Button(role: .destructive) {
                            listViewModel.deleteAll()                        } label: {
                            Label("Delete all Saved Locations", systemImage: "trash")
                        }
                    }
                    
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
