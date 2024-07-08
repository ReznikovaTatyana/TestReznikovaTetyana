//
//  CustomPickerView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import Foundation
import UIKit

//MARK: Протокол для делегата, який надає методи для зміни видимості View 
protocol CustomPickerViewDelegate {
    func viewIsHeaden(isHeaden: Bool)   
}

class CustomPickerView: UIView {
    
    // MARK: - Properties
    let closeButton = UIButton(type: .custom)
    let tickButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    let picker = UIPickerView()
    var delegate: CustomPickerViewDelegate?
    var filter = String()
    public var selectedCamera: String?
   
    struct ViewData {
        let centerLabelText: String
    }
    private var viewData: ViewData
    
    // MARK: - Initialization
    init(viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        setupUI()
        createCloseButton()
        createTickButton()
        createCameraLabel()
        createCameraPicker()
        makeConstraints()
    }
    
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    // MARK: - UI Creation
    
    //MARK: Налаштування загального вигляду в'ю
    private func setupUI() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 50
        self.layer.shadowColor = UIColor.black.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 16
        self.layer.shadowOpacity = 0.08
        self.layer.masksToBounds = false
        self.layer.borderWidth = 0.0
    }
   
    //MARK: Створення кнопки закриття вікна
    private func createCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "closeView")
        closeButton.setImage(image, for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFill
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.backgroundColor = .clear
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.addSubview(closeButton)
    }
    
    //MARK: Створення кнопки підтвердження вибору
    private func createTickButton() {
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Tick")
        tickButton.setImage(image, for: .normal)
        tickButton.imageView?.contentMode = .scaleAspectFill
        tickButton.contentVerticalAlignment = .fill
        tickButton.contentHorizontalAlignment = .fill
        tickButton.backgroundColor = .clear
        tickButton.addTarget(self, action: #selector(tickButtonTapped), for: .touchUpInside)
        self.addSubview(tickButton)
    }
    
    //MARK: Створення лейбла заголовка вікна
    private func createCameraLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = viewData.centerLabelText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
    }
    //MARK: Створення пікера для вибору камер
    private func createCameraPicker() {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tag = 1
        picker.selectRow(0, inComponent: 0, animated: true)
        self.addSubview(picker)
    }
    
    //MARK: Налаштування констрейнтів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 353),
            self.heightAnchor.constraint(equalToConstant: 312),
            
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            tickButton.heightAnchor.constraint(equalToConstant: 44),
            tickButton.widthAnchor.constraint(equalToConstant: 44),
            tickButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tickButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 329),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            titleLabel.widthAnchor.constraint(equalToConstant: 81),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 156),
            
            picker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            picker.widthAnchor.constraint(equalToConstant: 353),
            picker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            picker.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
        ])
    }
    
    //MARK: Обробник натискання кнопки закриття вікна
    @objc func closeView() {
            self.isHidden = true
        delegate?.viewIsHeaden(isHeaden: true)
        }
        
    //MARK: Обробник натискання кнопки підтвердження вибору
    @objc func tickButtonTapped() {
            delegate?.viewIsHeaden(isHeaden: true)
            picker.reloadAllComponents()
        }
}



