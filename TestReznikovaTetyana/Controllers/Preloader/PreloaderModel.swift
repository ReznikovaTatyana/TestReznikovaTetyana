//
//  PreloaderModel.swift
//  TestReznikovaTetyana
//
//  Created by mac on 10.09.2024.
//

import Foundation
import UIKit

class PreloaderModel {
    
    private weak var timer: Timer?
    var nextVC = HomeViewController()
    let pickerView = PickerModelView()
    var selectedDate = String()
    var photoArray = [Photo]()
    
    let nasa = NetworkMager(configuration: .default)
   
   
    
    func nextController(vc: UIViewController) {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { _ in
            vc.navigationController?.pushViewController(self.nextVC, animated: true)
        
        })
      
    }
//    
//    func photo() {
//        Task {
//            do {
//                let allPhotos = try await nasa.obtainRover()
//                for roverName in nasa.roverName {
//                    let ph = try await nasa.obtainPhoto(rover: roverName, date: "2015-6-3")
//                    DispatchQueue.main.async {
//                        self.photoArray.append(contentsOf: ph)
//                    }
//                   
//                    print(photoArray)
//               
//                }
//                
//               
//               
//            }
//            catch {
//                print("error")
//            }
//        }
//        
//    }
    
    

    
    
//    
//    func fetchRovers() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            NasaApi.shared.getRovers { [weak self] rover in
//                DispatchQueue.main.async {
//                    self?.pickerView.rovers.append(contentsOf: rover ?? [])
//                    //self?.rovarFilterView.picker.reloadAllComponents()
//                }
//                NasaApi.shared.getCameras(rover: rover ?? []) { [weak self]  camera in
//                    DispatchQueue.main.async {
//                        self?.pickerView.cameras.append(contentsOf: camera)
//                        //self?.cameraFilterView.picker.reloadAllComponents()
//                    }
//                    NasaApi.shared.getMaxDate(rover: rover ?? []) { [weak self] maxDate in
//                        
//                        DispatchQueue.main.async {
//                            self?.selectedDate = maxDate
//                            //self?.fetchPhotos()
//                        }
//                        
//                    }
//
//                }
//            }
//         
//        }
//    }
//    
//    
//    func fetchPhotos()  {
//        DispatchQueue.global(qos: .userInitiated).async {
//            NasaApi.shared.fetchPhotosForAllRovers(date: self.selectedDate) { [weak self] photos in
//                DispatchQueue.main.async {
//                    if let photos = photos {
//                        self?.photoArray = photos
////                        self?.filterContent()
////                        self?.cardCollectionView.reloadData()
//                    } else {
//                        print("Не вдалося отримати фотографії")
//                    }
//                }
//            }
//            
//        }
//        
//         }
    
    
}
