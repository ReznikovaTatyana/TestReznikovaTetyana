//
//  HomeCellModel.swift
//  TestReznikovaTetyana
//
//  Created by mac on 15.09.2024.
//

import Foundation
import UIKit

struct PhotoCellModel {
    let image: String
    let roverName: String
    let cameraName: String
    let earthDate: String
}


class HomeCellModel {
    
    
//    
//    var photo: Photo? {
//            didSet {
//                configureUI()
//            }
//        }
//    
//    func addLoader(loader: UIActivityIndicatorView, imageView: UIImageView) {
//        guard let photo = photo else { return }
//        //addAttributedText(photo: photo)
//        guard let url = URL(string: photo.image) else {return}
//            loader.startAnimating()
//      
//            NasaApi.shared.loadImage(url: url, imageView: imageView) { [weak self] image in
//                guard let self = self else {return}
//                DispatchQueue.main.async  {
//                    loader.stopAnimating()
//                    if self.photo?.image == photo.image {
//                        imageView.image = image
//                                }
//        }
//        }
//        
//    }
////    
//     func configureUI() {
//         func addLoader(loader: UIActivityIndicatorView, imageView: UIImageView) {
//             guard let photo = photo else { return }
//             addAttributedText(photo: photo)
//             guard let url = URL(string: photo.image) else {return}
//                 loader.startAnimating()
//           
//                 NasaApi.shared.loadImage(url: url, imageView: imageView) { [weak self] image in
//                     guard let self = self else {return}
//                     DispatchQueue.main.async  {
//                         loader.stopAnimating()
//                         if self.photo?.image == photo.image {
//                             imageView.image = image
//                                     }
//             }
//             }
//             
//         }
//         
//         
//            
//    }
    
//     func addAttributedText(photo: Photo) {
//        let stringRoverName = FormatterString.shared.formatterString(string: photo.earthDate)
//            roverLabel.attributedText = DisineString.shared.roverLabel(textApi: photo.rover.name)
//            cameraLabel.attributedText = DisineString.shared.cameraLabel(textApi: photo.camera.fullName)
//            dateLabel.attributedText = DisineString.shared.dateLabel(textApi: stringRoverName)
//       
//    }
    
    func att(label: UILabel) {
        
    }
    
}
