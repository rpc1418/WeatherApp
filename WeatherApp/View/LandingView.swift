//
//  LandingView.swift
//  WeatherApp
//
//  Created by rentamac on 24/01/2026.
//

import SwiftUI

struct LandingView: View {
    //    @State private var path = NavigationPath()
        @EnvironmentObject var router: AppRouter

        var body: some View {
    //        NavigationStack(path: $path) {

                ZStack {
                    Color("backgroundColor").ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("weather-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text("Breeze").foregroundStyle(.white)
                            .bold()
                            .font(.largeTitle)
                        Text("Weather App by Rudraksh Chourey")
                            .foregroundStyle(.gray)
                        Spacer()

    //                    NavigationLink(value: "NextScreen") {
    //                        Image(systemName: "arrow.right.circle.fill")
    //                            .font(.title2)
    //                            .foregroundStyle(.white)
    //                            .frame(width: 50, height: 50)
    //                            .background(Circle().fill(.blue))
    //                    }
    //                    NavigationLink(value: "DeveloperInfo") {
    //                        Text("See Developer info")
    //                            .padding()
    //                    }
                        
                        Button(action:{
//                            print("tapped")
                            router.navigate(to: .listLocationView)
                        }){
                            Image(systemName: "arrow.right")
                               .font(.title2)
                               .bold(true)
                               .foregroundStyle(.white)
                               .frame(width: 50, height: 50)
                               .background(Circle().fill(.blue))
                        }
                        Button(action:{
//                            print("tapped")
                            router.navigate(to: .developerView)
                        }){
                            Text("See Developer info")
                                .padding()
                                .foregroundStyle(.blue)
                        }
                    }
                }
//                .onAppear {
//                    print(" AppRouter available in landing view: \(String(describing: router))")
//                }
    //            .navigationDestination(for: String.self) { value in
    //                switch value {
    //                case "NextScreen":  ListView(path: $path)
    //                case "DeveloperInfo": DeveloperInfoView()
    //                default: EmptyView()
    //                }
    //            }
    //        }
    //        Text("number of view in stack:\(path.count)")
                
        }
    }
