//
//  HomeModel.swift
//  TestReznikovaTetyana
//
//  Created by mac on 14.09.2024.
//

import Foundation

struct HomeModelView {
    var rover: [String]
    var camera: [RoverCamera]
    var photo: [Photo]
}

class HomeModel {
    private var filterCard = [Photo]()
    let nasa = NetworkMager(configuration: .default)
    var photoArray: [Photo] = []
    var dateGetApi = String()
   
  
    func getPhoto(dateString: String) async throws -> HomeModelView {
                let photo = try await nasa.abtainAllPhoto(date: dateString)
                let rover = try await nasa.getRoverName()
                let camera = try await nasa.getCamera()
                let model = HomeModelView(rover: rover, camera: camera, photo: photo)
                return model
    }
    
    
    func filterPickerArray(pickerModel: PickerModelView, date: String, camera: String, rover: String) async throws -> [Photo] {
        let model = try await getPhoto(dateString: date)
        photoArray = model.photo
        pickerModel.rovers.append(contentsOf: model.rover.filter({!pickerModel.rovers.contains($0)}))
        pickerModel.cameras.append(contentsOf: model.camera.filter({!pickerModel.cameras.contains($0)}))
        
        return photoArray
    }
    
    func filt(cam: String, rov: String) -> [Photo] {
        var array: [Photo] = []
        if cam.lowercased() == "all" && rov.lowercased() == "all" {
           array = photoArray
        } else {
            array = photoArray.filter({ array in
                let matchesCamera = cam.lowercased() == "all" || array.camera.fullName.lowercased() == cam.lowercased()
                let matchesRover = rov.lowercased() == "all" || array.rover.name.lowercased() == rov.lowercased()
                return matchesCamera && matchesRover
            })
        }
        
        print(array.count)
       return array
        
        
    }
    
   
    
    
//    func filterContentForSearchText(cam: String, rov: String, photoArray: [Photo]) -> [Photo] {
//        var array: [Photo] = []
//        if cam.lowercased() == "all" && rov.lowercased() == "all" {
//           array = photoArray
//        } else {
//            array = photoArray.filter({ array in
//                let matchesCamera = cam.lowercased() == "all" || array.camera.fullName.lowercased() == cam.lowercased()
//                let matchesRover = rov.lowercased() == "all" || array.rover.name.lowercased() == rov.lowercased()
//                return matchesCamera && matchesRover
//            })
//            
//            print(filterCard.map({$0.earthDate}))
//        }
//        
//        print(array.count)
//       return array
//        
//    }
    
   
}


