//
//  PreloaderView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 10.09.2024.
//

import Foundation
import UIKit

class PreloaderView: UIView {
    
    private lazy var firstCircle: UIView = UIView()
    private lazy var secondCircle: UIView = UIView()
    private lazy var thirdCircle: UIView = UIView()
    private lazy var fourthCircle: UIView = UIView()
       
   
    private var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Icon")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private var stack: UIStackView = {
        let conteiner = UIStackView()
        conteiner.backgroundColor = .white
        conteiner.axis = .horizontal
        conteiner.alignment = .center
       // conteiner.spacing = 0
        conteiner.distribution = .equalSpacing
        
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        return conteiner
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(stack)
        self.addSubview(logoImage)
        makeConstraintes()
        createCercles()
        addAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCercles() {
        for circle in [firstCircle, secondCircle, thirdCircle, fourthCircle] {
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.layer.cornerRadius = 6
            circle.backgroundColor = .projectOrange
            stack.addArrangedSubview(circle)
           }
    }
    
    
    private func makeConstraintes() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -114),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 111),
            stack.heightAnchor.constraint(equalToConstant: 34),
            
        ])
        
        for circle in [firstCircle, secondCircle, thirdCircle, fourthCircle] {
               circle.heightAnchor.constraint(equalToConstant: 12).isActive = true
               circle.widthAnchor.constraint(equalToConstant: 12).isActive = true
           }
    }
    
    
    private func addAnimation() {
        let circles = [self.firstCircle, self.secondCircle, self.thirdCircle, self.fourthCircle]
        let startTimes: [Double] = [0, 0.15, 0.3, 0.45]
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .repeat) {
            for (index, circle) in circles.enumerated() {
                let startTime = startTimes[index]
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: 0.33) {
                    circle.transform = CGAffineTransform(translationX: 0, y: -12)
                }
                UIView.addKeyframe(withRelativeStartTime: startTime + 0.3, relativeDuration: 0.33) {
                    circle.transform = CGAffineTransform(translationX: 0, y: 10)
                }
                UIView.addKeyframe(withRelativeStartTime: startTime + 0.5, relativeDuration: 0.33) {
                    circle.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
