//
//  CustomButton.swift
//  TestReznikovaTetyana
//
//  Created by mac on 08.07.2024.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    // MARK: - Properties
    let imageViewCustomButton = UIImageView()
    let labelCustomButton = UILabel()
    
   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
        
    }
    
    public func setupButton(image: String) {
        self.backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        imageViewCustomButton.image =  UIImage(named: image)
        imageViewCustomButton.translatesAutoresizingMaskIntoConstraints = false
        labelCustomButton.translatesAutoresizingMaskIntoConstraints = false
        labelCustomButton.text = "All"
        labelCustomButton.font = UIFont.customFont
        addSubview(labelCustomButton)
        addSubview(imageViewCustomButton)
        NSLayoutConstraint.activate([
            
            imageViewCustomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            imageViewCustomButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageViewCustomButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            imageViewCustomButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            
            labelCustomButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            labelCustomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelCustomButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelCustomButton.leadingAnchor.constraint(equalTo: imageViewCustomButton.trailingAnchor, constant: 6)
        ])
    }
    
}



