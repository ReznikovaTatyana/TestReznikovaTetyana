//
//  PickerModelView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 07.07.2024.
//

import Foundation


class PickerModelView {
    var cameras = [Camera(name: "All", fullName: "All")]
    var rovers = [Rover(id: 0, name: "All", landingDate: "", launchDate: "", status: "", maxSol: 0, maxDate: "", totalPhotos: 0, cameras: [])]  
}


