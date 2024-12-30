////
//  ApiModel.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import Foundation

struct RoverName {
    let curiosity = "Curiosity"
    let spirit = "Spirit"
    let opportunity = "Opportunity"
    let perseverance = "Perseverance"
}


struct  PhotosElement: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let camera: PhotoCamera
    let image: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case image = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
}

struct PhotoCamera: Decodable {
    let name: String
    let roverId: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}



struct RoverArray: Decodable {
    let rovers: [Rover]
}

// MARK: - Rover
struct Rover: Decodable {
    let name: String
    let maxDate: String
    let cameras: [RoverCamera]

    enum CodingKeys: String, CodingKey {
        case name
        case maxDate = "max_date"
        case cameras
    }
}


// MARK: - Camera
struct RoverCamera: Decodable, Hashable {
    let name, fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
