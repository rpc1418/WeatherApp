//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI
import Combine
import CoreData

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var locations: [Location] = []
    let testLocations: [(name: String, lat: Double, lon: Double)] = [
        ("New York", 40.7128, -74.0060),
        ("London", 51.5074, -0.1278),
        ("Paris", 48.8566, 2.3522),
        ("Sydney", -33.8688, 151.2093),
        ("Reykjavik", 64.1355, -21.8954),
        ("Tokyo", 35.6762, 139.6503),
        ("São Paulo", -23.5505, -46.6333),
        ("Berlin", 52.5200, 13.4050),
        ("Seattle", 47.6062, -122.3321),
        ("Denver", 39.7392, -104.9903)
    ]
//
//    @Published var container: NSPersistentContainer
    private var prCon = PersistenceController.shared
    init(){
//        container = NSPersistentContainer(name: "LocationModel")
//        container.loadPersistentStores { (_, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }else {
//                print("Container Connectd successfully")
//            }
//        }
        
        loadLocations()
    }
    
    func loadLocations(){
        locations=prCon.fetchLocations()
    }
//
    
    func addLocation(name: String,latitude: Double, longitude: Double){
        prCon.createLocation(name: name, latitude: latitude, longitude: longitude)
        saveContext()
    }
    
    func deleteTask(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = locations[index]
        prCon.weatherListContainer.viewContext.delete(entity)
        saveContext()
    }
    
    func saveContext(){
        prCon.saveContext()
        loadLocations()
    }
    

    func addTestLocations() {
        testLocations.forEach { name, lat, lon in
            prCon.createLocation(name: name, latitude: lat, longitude: lon)
        }
        saveContext()
    }
    
    func deleteAll() {
        prCon.deleteAllLocations()
        loadLocations()
    }
    
    func deleteByEntity(location: Location){
        prCon.weatherListContainer.viewContext.delete(location)
        saveContext()
    }
    
    func updateLocation(location:Location, name: String,latitude: Double, longitude: Double){
        location.name = name
        location.latitude = latitude
        location.longitude = longitude
        saveContext()
    }

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        } else {
            let term = searchText.lowercased()
            return locations.filter {
                ($0.name ?? "").lowercased().contains(term)
            }
        }
    }

}

