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
                                    .foregroundColor(Color("foregroundColor"))
                                Spacer()
                                Text(location.temperature ?? "---")
                                    .font(.headline)
                                    .foregroundColor(Color.foreground)

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
                                .tint(Color("foregroundColor"))
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
                                .tint(Color("foregroundColor"))
                                .frame(width: 50, height: 50)
                                .rotationEffect(
                                    .degrees(showAddNewLocation ? 45 : 0)
                                )
                        }

                    }
                    ToolbarItem(placement: .principal) {
                        Text("Locations")
                            .tint(Color("foregroundColor"))
                    }
                }
                ).searchable(
                    text: $listViewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search any location...!"
                )
                
                if showAddNewLocation {
                    AddEditLoc(name: $name, latitude: $latitude, longitude: $longitude, showAddNewLocation: $showAddNewLocation, dummyLocationForUpdate: $dummyLocationForUpdate, listViewModel: listViewModel, forEdit: $forEdit)
//                        .padding(.bottom,-15)
                 
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
