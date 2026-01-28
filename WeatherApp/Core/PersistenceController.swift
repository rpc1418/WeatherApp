//
//  PersistenceController.swift
//  WeatherApp
//
//  Created by rentamac on 28/01/2026.
//

import CoreData


final class PersistenceController {
    
    static let shared = PersistenceController()
    let weatherListContainer: NSPersistentContainer
    
    private init() {
        weatherListContainer = NSPersistentContainer(name: "LocationModel")
        weatherListContainer.loadPersistentStores { _, error in
            if let error {
                print("Core Data load error:", error.localizedDescription)
            }
        }
    }
    
    
    func saveContext() {
        let context = weatherListContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error:", error.localizedDescription)
            }
        }
    }
    
    func createLocation(name: String,latitude: Double, longitude: Double){
        let location=Location(context: weatherListContainer.viewContext)
        location.name=name
        location.latitude=latitude
        location.longitude=longitude
        location.weather="wind"
        location.humidity="---"
        location.precipitationProbablity="---"
        location.rainSum="---"
        location.sunrise="---"
        location.sunset="---"
        location.uvIndex="---"
        location.windSpeed="---"
        location.id = UUID()
        location.temperature = "---"
        saveContext()
    }


    func fetchLocations()-> [Location]{
        let fetchReq = NSFetchRequest<Location>(entityName: "Location")
        do {
            return try weatherListContainer.viewContext.fetch(fetchReq)
        } catch let error{
                print("print the error \(error)")
        }
        return []
    }

    func updateLocation(location: Location, weatherinfo: WeatherData){
        location.temperature=weatherinfo.temperature
        location.humidity=weatherinfo.humidity
        location.precipitationProbablity=weatherinfo.precipitationProbablity
        location.rainSum=weatherinfo.rainSum
        location.sunrise  = weatherinfo.sunrise
        location.sunset=weatherinfo.sunset
        location.uvIndex=weatherinfo.uvIndex
        location.windSpeed=weatherinfo.windSpeed
        location.weather=weatherinfo.weather
        location.lastUpdated=Date()
        
        saveContext()
    }
   
    
    func deleteAllLocations() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Location.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try weatherListContainer.viewContext.execute(deleteRequest)
        } catch {
            print("Delete error: \(error.localizedDescription)")
        }
    }

    
}
