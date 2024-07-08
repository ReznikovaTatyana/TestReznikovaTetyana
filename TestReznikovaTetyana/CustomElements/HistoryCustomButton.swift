//
//  HistoryCustomButton.swift
//  TestReznikovaTetyana
//
//  Created by mac on 05.07.2024.
//

import Foundation
import UIKit

class HistoryCustomButton: UIView {
    
    let button = UIButton()
    
    init() {
        super.init(frame: .zero)
        createCloseButton()
    }
    
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func createCloseButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 44/255, alpha: 1)
        let image = UIImage(named: "history")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 35
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.backgroundColor = .clear
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 70),
            button.widthAnchor.constraint(equalToConstant: 70),
        ])
        
    }
        
    }
    
    
