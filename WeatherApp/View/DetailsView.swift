//
//  DetailsView.swift
//  WeatherApp
//
//  Created by rentamac on 23/01/2026.
//

import SwiftUI
import Combine

struct DetailsView: View {
    @StateObject var detailsViewModel: DetailsViewModel = DetailsViewModel()
    @EnvironmentObject var router: AppRouter
    var location: Location
    @State var fromLiveApi: Bool = false
    @State var lastUpdatedTime: Double = 0.0
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()

            VStack {
                Spacer()

                if detailsViewModel.isLoading {
                    Text("Loading...")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                    Spacer()
                } else if detailsViewModel.errorMessage == nil{
                    Text("\(location.name ?? "---")")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                    Text(
                        "Precipitation Probablity:\(location.precipitationProbablity  ?? "---")"
                    )
                    .font(.system(size: 18))
                    .foregroundStyle(.gray)
                    Image(systemName: location.weather ?? "sun.max")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.yellow)
                    Text(location.temperature ?? "na")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Button {
                        fromLiveApi=true
                        Task{
                            await detailsViewModel.loadWeather(location: location)
                            lastUpdatedTime = detailsViewModel.timeUpdatedLast(location: location)
                        }
                       
                    } label: {
                        if fromLiveApi {
                            Text("from Live")
                                .foregroundStyle(Color.white)
                                .bold()
                        } else {
                            Text("from Save")
                                .foregroundStyle(Color.white)
                                .bold()
                            
                        }
                    }
                    .padding(5)
                    .background(!fromLiveApi ? .orange : .green)
                    .cornerRadius(30)
//                    if !fromLiveApi{
                        Text(
                            "fetched \(lastUpdatedTime)sec ago"
                        )
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
//                    }
                    VStack {
                        HStack(spacing: 12) {
                            InfoCard(
                                title: "UV Index",
                                value: location.uvIndex ?? "NA"
                            )
                            InfoCard(
                                title: "Wind Speed",
                                value: location.windSpeed ?? "NA"
                            )
                        }
                        .padding(.horizontal).padding(.vertical, 10)
                        HStack(spacing: 12) {
                            InfoCard(
                                title: "Rain",
                                value: location.rainSum ?? "---"
                            )
                            InfoCard(
                                title: "Humidity",
                                value: location.humidity ?? "---"
                            )
                        }
                        .padding(.horizontal).padding(.vertical, 10)
                        HStack(spacing: 12) {
                            InfoCard(
                                title: "Sunrise",
                                value: location.sunrise ?? "---"
                            )
                            InfoCard(
                                title: "Sunset",
                                value: location.sunset ?? "---"
                            )
                        }
                        .padding(.horizontal).padding(.vertical, 10)
                    }
                    
                }
                if detailsViewModel.errorMessage != nil {
                    Text("\(detailsViewModel.errorMessage!)")
                        .font(.title)
                        .foregroundStyle(.white)
                }
            }
        }
        .task {
            lastUpdatedTime = detailsViewModel.timeUpdatedLast(location: location)
        if(lastUpdatedTime>60 || location.lastUpdated == nil){
                
                await detailsViewModel.loadWeather(location: location)
                fromLiveApi = true
                lastUpdatedTime = detailsViewModel.timeUpdatedLast(location: location)
            }else{
                fromLiveApi=false
            }
            
        }
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
            ToolbarItem(placement: .principal) {
                Text("\(location.name ?? "---")'s Weather")
                    .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    router.goToHome()
                }) {
                    Image(systemName: "house")
                        .font(.title2)
                        .bold(true)
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                }
            }
        }
        )
        
        
        .navigationBarBackButtonHidden()
    }
}
