////
////  NetworkMager.swift
////  TestReznikovaTetyana
////
////  Created by mac on 15.09.2024.
////
//
//import Foundation
//import UIKit
//
//class NetworkMager {
//    private let session: URLSession
//    
//    lazy var jsonDecoder: JSONDecoder = {
//        JSONDecoder()
//    }()
//    
//    init(configuration: URLSessionConfiguration) {
//        session = URLSession(configuration: configuration)
////        session.configuration.timeoutIntervalForRequest = 30.0
////        session.configuration.timeoutIntervalForResource = 60.0
//    }
//    
//    
//    var photoArray = [Photo]()
//    var roverName: [String] = []
//    
//    private let apiKey = "xN6hKEZPSBB251oQS4LnsxM8GFoarTfoKip10BFt"
//    //ObeaELebJgrYzI6mNBEe7LIWlzC4Os5uU2h3c799
//    private let baseUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
//    
//    
//    private func createURLForPhoto(rover: String, date: String) -> URL? {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.nasa.gov"
//        components.path = "/mars-photos/api/v1/rovers/\(rover)/photos"
//        components.queryItems = [
//            URLQueryItem(name: "earth_date", value: date),
//            URLQueryItem(name: "api_key", value: apiKey)
//        ]
//        return components.url
//    }
//    
//    func obtainRover() async throws -> [Rover]{
//        guard let urlString = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=Vtz4MAaa0MWVp551iMvNr8glKtXiYB99qrwIN61B") else {return [] }
//        let urlRequest = URLRequest(url: urlString)
//        let responseData = try await session.data(for: urlRequest)
//        let result = try jsonDecoder.decode(RoverArray.self, from: responseData.0)
//       
//        for rov in result.rovers {
//            roverName.append(rov.name)
//        }
//
//        
//        print(roverName)
//        return result.rovers
//    }
//    
//    
//    func obtainPhoto(rover: String, date: String) async throws -> [Photo] {
//        guard let url = createURLForPhoto(rover: rover, date: date) else {return [] }
//        let urlRequest = URLRequest(url: url)
//        
//        let responseData = try await session.data(for: urlRequest)
//        let result = try jsonDecoder.decode(PhotosElement.self, from: responseData.0)
//       // photoArray.append(contentsOf: result.photos)
//        //print(result.photos)
//        return result.photos
//    }
//    
//    
//    func abtainAllPhoto(date: String) async throws -> [Photo] {
//        var allPhotos: [Photo] = []
//        
//        await withTaskGroup(of: [Photo].self) { group in
//            for rover in roverName {
//                group.addTask {
//                    return try! await self.obtainPhoto(rover: rover, date: date)
//                }
//            }
//            
//            for await photos in group {
//                allPhotos.append(contentsOf: photos)
//            }
//        }
//        
//        return allPhotos
//    }
//
//    
////    func abtainAllPhoto(date: String) async throws -> [Photo] {
////        var allPhotos: [Photo] = []
////       
////        for rover in roverName {
////            let photos = try await obtainPhoto(rover: String(rover), date: date)
////            allPhotos.append(contentsOf: photos)
////        }
////        return allPhotos
////    }
//    
//    func getPhoto() async  throws {
//        for roverName in roverName {
//            _ = try await obtainPhoto(rover: roverName, date: "2015-6-3")
//        }
//        
//    }
//    
//}


import Foundation

class NetworkMager {
    private let session: URLSession
    
    lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
        session.configuration.timeoutIntervalForRequest = 30.0 // або інший час
        session.configuration.timeoutIntervalForResource = 60.0 
    }
    
    var photoArray = [Photo]()
    var roverName: [String] = []
    
    private let apiKey = "eOBFVNRaYh5XSPteBUAjdzYcTmTUgIOP9tqaGm5f"
    private let baseUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    
    // Створюємо URL для запиту фото з конкретного ровера на конкретну дату
    private func createURLForPhoto(rover: String, date: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/\(rover)/photos"
        components.queryItems = [
            URLQueryItem(name: "earth_date", value: date),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return components.url
    }
    
    // Отримуємо список всіх роверів
    func obtainRover() async throws -> [Rover] {
        guard let urlString = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=\(apiKey)") else {
            return []
        }
        let urlRequest = URLRequest(url: urlString)
        
        // Виконуємо запит на сервер
        let (responseData, _) = try await session.data(for: urlRequest)
        
        // Декодуємо дані з JSON
        let result = try jsonDecoder.decode(RoverArray.self, from: responseData)
       
        // Зберігаємо імена роверів
        for rov in result.rovers {
            roverName.append(rov.name)
        }
        

        return result.rovers
    }
    
    // Отримуємо фото з конкретного ровера на конкретну дату
    func obtainPhoto(rover: String, date: String) async throws -> [Photo] {
        guard let url = createURLForPhoto(rover: rover, date: date) else { return [] }
        let urlRequest = URLRequest(url: url)
        
        // Виконуємо запит на сервер
        let (responseData, _) = try await session.data(for: urlRequest)
        
        // Декодуємо фото з JSON
        let result = try jsonDecoder.decode(PhotosElement.self, from: responseData)
       
        return result.photos
        
    }
    
    func getRoverName() async throws -> [String] {
        var roverName: [String] = []
        let rover = try await obtainRover()
        let name = rover.map({$0.name})
        roverName.append(contentsOf: name)
        return roverName
    }
    
    func getCamera() async throws -> [RoverCamera] {
        var roverCamera = [RoverCamera]()
        let rover = try await obtainRover()
        for camera in rover {
            roverCamera.append(contentsOf:  camera.cameras.filter({!roverCamera.contains($0)}))
        }
        return roverCamera
    }
    
    // Отримуємо всі фото для всіх роверів на задану дату
    func abtainAllPhoto(date: String) async throws -> [Photo] {
        var allPhotos: [Photo] = []
        
        // Використовуємо withThrowingTaskGroup для асинхронних запитів
        try await withThrowingTaskGroup(of: [Photo].self) { group in
          let rover =  try await obtainRover()
            let roverName = rover.map({$0.name})
            for rover in  roverName {
                    let photos =  try await self.obtainPhoto(rover: rover, date: date)
                    allPhotos.append(contentsOf: photos)
            }
        }
        return allPhotos
    }

    // Викликаємо отримання фото для всіх роверів на певну дату
//    func getPhoto() async throws -> [Photo] {
//        var allPhotos: [Photo] = []
//      
//            let photos = try await abtainAllPhoto(date: "2024-06-03")
//            print(photos)
//            allPhotos.append(contentsOf: photos)
//        
//        return allPhotos
//    }
}
