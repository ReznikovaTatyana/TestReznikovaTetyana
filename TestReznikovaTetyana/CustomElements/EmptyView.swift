//
//  EmptyView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 10.12.2024.
//

import Foundation
import UIKit

class EmptyView: UIView {
    var emptyLabel = UILabel()
    var loader = UIActivityIndicatorView()
    
    struct ViewData {
        let viewController: UIView
        let loaderIsHeaden: Bool
        let labelIsHeaden: Bool
    }
    
    private var viewData: ViewData
    
    // MARK: - Initialization
    init(viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        addSubview(emptyLabel)
        addSubview(loader)
        createLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createLabel() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .large
        loader.color = .projectGrey
        loader.isHidden = viewData.loaderIsHeaden
       // loader.hidesWhenStopped = true
           
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.isHidden = viewData.labelIsHeaden
        emptyLabel.text = "За обраною датою данні не знайдено. Оберіть іншу дату!"
        emptyLabel.font = UIFont.customFont
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = .zero
    
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyLabel.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            emptyLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            loader.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            ])
    }
}
