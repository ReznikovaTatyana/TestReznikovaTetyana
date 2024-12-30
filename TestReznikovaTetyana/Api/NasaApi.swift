//
//  NasaApi.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//
import UIKit
import SDWebImage


class NasaApi {
   
    
    static let shared = NasaApi()
    private init() {}
    
  
    var photoArray = [Photo]()
    
    private let apiKey = "xN6hKEZPSBB251oQS4LnsxM8GFoarTfoKip10BFt"
    //ObeaELebJgrYzI6mNBEe7LIWlzC4Os5uU2h3c799
    private let baseUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
   
    
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
    
   
    
    
    
  
    
      
    
    
    func getRovers(completion: @escaping ([Rover]?)-> Void){
        let startTime = CFAbsoluteTimeGetCurrent()
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=Vtz4MAaa0MWVp551iMvNr8glKtXiYB99qrwIN61B"

        
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                
                //print("Network error:", error ?? "Unknown error")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                   print("Received JSON: \(jsonString)")
               } else {
                   //print("Failed to convert data to string")
               }
            
            do {
                let result = try JSONDecoder().decode(RoverArray.self, from: data)
                completion(result.rovers)
            } catch {
               // print("Decoding error:", error)
            }
                let endTime = CFAbsoluteTimeGetCurrent()
                print("API request time: \(endTime - startTime) seconds")
            
        }.resume()
        
        
    }
    
  
    
    
    func getCameras(rover: [Rover], completion: @escaping([RoverCamera]) -> Void) {
        let cameras = rover.flatMap({$0.cameras})
        var filterCmeras: [RoverCamera] = []
        for camera in cameras {
            if !filterCmeras.contains(camera) {
                filterCmeras.append(camera)
                    }
                }
        completion(filterCmeras)
    }
    
    func getMaxDate(rover: [Rover], completion: @escaping(String) -> Void) {
        let maxDate = rover.map({$0.maxDate})
        guard let lastMaxDate = maxDate.last else {return}
        completion(lastMaxDate)
    }
    
    
//    
    func fetchPhoto(rover: String, date: String, completion: @escaping([Photo]?) -> Void) {
    
        guard let url = createURLForPhoto(rover: rover, date: date) else {
            print("Failed to create URL")
            return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error:", error ?? "Unknown error")
                
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PhotosElement.self, from: data)
                completion(result.photos)
            } catch {
                print(error)
            }
        }.resume()
    }
//    
//   
//    
    func fetchPhotosForAllRovers(date: String, completion: @escaping ([Photo]?) -> Void) {
        
        getRovers { [weak self] rover in
            guard let self = self, let rovers = rover else {return}
            
            let roversNames = rovers.map { $0.name }
            var allPhotos: [Photo] = []
            let group = DispatchGroup()
            for rover in roversNames {
                group.enter()
                fetchPhoto(rover: rover, date: date) { photos in
                    if let photos = photos {
                        allPhotos.append(contentsOf: photos)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                completion(allPhotos)
            }
        }
        
    }
    
//    func getPhoto(photos: [Photo], completion: @escaping([String]) -> Void) {
//        let photo = photos.map({$0.image})
//        completion(photo)
//    }
//    
    func loadImage(url: URL, imageView: UIImageView, completion: @escaping(UIImage?) -> Void) {
//
        imageView.sd_setImage(with: url) { image, error, cacheType, url in
            if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
            } else if image != nil {
                   // print("Image loaded successfully from \(cacheType == .none ? "network" : "cache")")
                }
                imageView.image = image
                completion(image)
            }
        }
  
    }


