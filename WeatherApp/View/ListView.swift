//
//  ListView.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI

struct ListView: View {
//    @Binding var path: NavigationPath
    @EnvironmentObject var router: AppRouter 
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some View {
        ZStack{
    
            Color("backgroundColor").ignoresSafeArea()
            VStack{
//                HStack{
//                    Button(action: {
//                        path.removeLast()  // Your action: navigate, toggle, etc.
//                    }) {
//                        Image(systemName: "arrow.left.circle.fill")
//                            .font(.title2)
//                            .foregroundStyle(.white)
//                            .frame(width: 50, height: 50)
//                            .background(Circle().fill(.blue))
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.horizontal,20)
//                    
//                    Text("Locations")
//                        .foregroundStyle(.white)
//                    Spacer()
//                }
//               Spacer()
                List(listViewModel.filteredLocations){
                    location in
//                    NavigationLink(value: location){
//                        HStack{
//                            Text(location.name)
//                                .font(.headline)
//                                .foregroundColor(.white)
//                            Spacer()
//                            Image(systemName: location.weather.icon)
//                                .foregroundStyle(.yellow)
//                        }
//                    }
                    Button(action:{router.navigate(to: .locationDetailView(location: location))}){
                                                HStack{
                                                    Text(location.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    Spacer()
                                                    Image(systemName: location.weather.icon)
                                                        .foregroundStyle(.yellow)
                                                }
                    }
                    .listRowBackground(Color.clear)
                       
                }
//                .navigationDestination(for: Location.self){
////                    location in DetailsView( path: $path, location: location)
//                    location in DetailsView(  location: location)
//                }
                .scrollContentBackground(.hidden)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading){
                        Button(action: {
//                            path.removeLast()
                            router.goBack()
                        }) {
                            Image(systemName: "arrow.left")
                               .font(.title2)
                               .bold(true)
                               .foregroundStyle(.white)
                               .frame(width: 50, height: 50)
                        }
                      
                    }
                    ToolbarItem(placement: .principal){
                        Text("Locations")
                            .foregroundStyle(.white)
                    }
                }
                ).searchable(text: $listViewModel.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt:"Search any location...!")
                
               
                Button("See Developer Info") {
//                    path.append("DeveloperInfo")
                    router.navigate(to: .developerView)
                }
                
//                Spacer()
                 
            }
        }
//        .onAppear {
//            print(" AppRouter available in List view: \(String(describing: router))")
//        }

        .navigationBarBackButtonHidden()
    }
    
}

