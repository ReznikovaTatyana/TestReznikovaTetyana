////
////  NasaApi.swift
////  TestReznikovaTetyana
////
////  Created by mac on 04.07.2024.
////

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}

func dates(from startDate: Date, to endDate: Date) -> [Date] {
    var dates: [Date] = []
    var currentDate = startDate

    while currentDate <= endDate {
        dates.append(currentDate)
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }

    return dates
}

class NasaApi {
    static let shared = NasaApi()
    
    private let apiKey = "Aq49iFWIdiqdvRsRgROCScApieyEgkIm5ZQfoERw"
    private let baseUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    private var rovers: [Rover] = []
    var cameras: [(name: String, fullName: String)] = []
    
    func getRovers(completion: @escaping ([Rover]?) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers?/photos?earth_date?&api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching rovers: \(error)")
                completion(nil)
                return
            } else if let resp = response as? HTTPURLResponse {
                print("Response status code: \(resp.statusCode)")
            }
            
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            do {
                let roversResponse = try JSONDecoder().decode(MarsRoverPhotos.self, from: responseData)
                self.rovers = roversResponse.rovers
                self.cameras = self.rovers.flatMap { rover in
                    rover.cameras.map { camera in
                        (name: camera.name, fullName: camera.fullName)
                    }
                }
                completion(roversResponse.rovers)
            } catch {
                print("Error decoding JSONrover: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func getPhotos(rover: String, camera: String, date: String, completion: @escaping ([Photo]?) -> Void) {
        let urlString = "\(baseUrlString)/\(rover)/photos?earth_date=\(date)&camera=\(camera)&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        print("Fetching photos for rover: \(rover), camera: \(camera), date: \(date)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching photos: \(error)")
                completion(nil)
                return
            } else if let resp = response as? HTTPURLResponse {
                print("Response status code: \(resp.statusCode)")
            }
            
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            do {
                let photosResponse = try JSONDecoder().decode(PhotoResponse.self, from: responseData)
                completion(photosResponse.photos)
            } catch {
                print("Error decoding JSONphoto: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func getAllPhotos(date: String, completion: @escaping ([Photo]) -> Void) {
        var allPhotos: [Photo] = []
        let dispatchGroup = DispatchGroup()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let maxDate = Date.now
        
        for rover in rovers {
            guard let landingDate = rover.landingDate.toDate() else { continue }
            let datesArray = dates(from: landingDate, to: maxDate)
            
            for camera in cameras {
                for dat in datesArray.prefix(7) { // Обмеження до 7 днів
                    dispatchGroup.enter()
                    let dateString = dateFormatter.string(from: dat)
                    getPhotos(rover: rover.name, camera: camera.name, date: dateString) { photos in
                        if let photos = photos {
                            allPhotos.append(contentsOf: photos)
                        }
                        dispatchGroup.leave()
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(allPhotos)
        }
    }
}
