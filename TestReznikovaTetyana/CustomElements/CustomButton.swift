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
        labelCustomButton.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(labelCustomButton)
        addSubview(imageViewCustomButton)
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 140),
            self.heightAnchor.constraint(equalToConstant: 38),
            
            imageViewCustomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            imageViewCustomButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            imageViewCustomButton.widthAnchor.constraint(equalToConstant: 24),
            imageViewCustomButton.heightAnchor.constraint(equalToConstant: 24),
            
            labelCustomButton.heightAnchor.constraint(equalToConstant: 22),
            labelCustomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelCustomButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            labelCustomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 37)
        ])
    }
    
}

