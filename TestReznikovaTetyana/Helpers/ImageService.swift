//
//  ImageService.swift
//  TestReznikovaTetyana
//
//  Created by mac on 17.09.2024.
//

import Foundation
import UIKit

class ImageService {
    
    static func downloadImage(urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { return nil}
       let imageResponse = try await URLSession.shared.data(from: url)
        let result = UIImage(data: imageResponse.0)
        return result
        
    }
}
