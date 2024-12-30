//
//  ExtentionString.swift
//  TestReznikovaTetyana
//
//  Created by mac on 20.08.2024.
//

import Foundation
import UIKit

enum Text: String {
    case roverName = "Rover: "
    case cameraName = "Camera: "
    case date = "Date: "
    
    func getString() -> String {
            return self.rawValue
        }
}

class DisineString {
   
    static var shared = DisineString()
    let defaultFont = UIFont.systemFont(ofSize: 16)
//    private let customFontName = "SFPro-Regular"
//    private let customFontBold = "SFProText-Bold"
    
  private func attributedString(text: String, textApi: String) -> NSMutableAttributedString  {
        let roverAttributedText = NSMutableAttributedString(string: text, attributes: [
               .foregroundColor: UIColor.projectGrey,
               .font: UIFont.customFontCell ?? defaultFont
           ])
           roverAttributedText.append(NSAttributedString(string: textApi, attributes: [
               .foregroundColor: UIColor.black,
               .font: UIFont.customFontBoldCell ?? defaultFont
           ])) 
        return roverAttributedText
        
    }
    
   public func roverLabel(textApi: String) -> NSMutableAttributedString {
        return attributedString(text: Text.roverName.getString(), textApi: textApi)
    }
    
    public func cameraLabel(textApi: String) -> NSMutableAttributedString {
         return attributedString(text: Text.cameraName.getString(), textApi: textApi)
     }
    
    public func dateLabel(textApi: String) -> NSMutableAttributedString {
         return attributedString(text: Text.date.getString(), textApi: textApi)
     }
}

extension UIFont {
//    enum Font: String {
//        case sfProRegular = "SFPro-Regular"
//        case sfProBold = "SFProText-Bold"
//        
//        func getString() -> String {
//                return self.rawValue
//            }
//    }
    
    public static var customFontCell = UIFont(name: "SFPro-Regular", size: 16)
    public static var customFontBoldCell = UIFont(name: "SF Pro Text", size: 16)
    public static var customFont = UIFont(name: "SF Pro Text", size: 17)
    public static var customFontLargeTitle = UIFont(name: "SF Pro Text", size: 34)
}




class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    func loadImage(url: URL, completion: @escaping(UIImage) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            guard  let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
}
