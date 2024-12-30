//
//  HeaderCollectionView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import Foundation
import UIKit

//MARK: Протокол для делегата, який надає методи для зміни видимості календаря, камери і ровера
protocol HeaderCollectionViewDelegate: AnyObject {
    func changeHidenCalendarView(isHeadenView: Bool)
    func changeHidenCameraView(isHeadenView: Bool)
    func changeHidenRoverView(isHeadenView: Bool)
}

class HeaderCollectionView: UIView {
   
    // MARK: - Properties
    let titleMars = UILabel()
    var dateLabel = UILabel()
    let calendarButton = UIButton(type: .custom)
    let filterRoverButton = CustomButton()
    let filterCameraButton = CustomButton()
    let saveFilterButton = UIButton(type: .custom)
    let image = UIImageView()
    weak var delegate: HeaderCollectionViewDelegate?
    
 
    struct InitView {
        let viewController: UIView
    }
    private var initView: InitView
    
    
    // MARK: - Initialization
    init(initView: InitView) {
        self.initView = initView
        super.init(frame: .zero)
        initView.viewController.addSubview(self)
        self.backgroundColor = .projectOrange
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Налаштування інтерфейсу
    private func setupView() {
        createTitleMars()
        createDateLabel()
        createCalendarButton()
        creatFilterRoverButton()
        createFilterCameraButton()
        createSaveFilterButton()
        makeConstraints()
    }
    
    // MARK: Створення заголовку "MARS.CAMERA"
    private func createTitleMars() {
        titleMars.translatesAutoresizingMaskIntoConstraints = false
        titleMars.font = UIFont.customFontLargeTitle
        titleMars.numberOfLines = 1
        titleMars.textAlignment = .left
        titleMars.text = "MARS.CAMERA"
        titleMars.textColor = .projectBlack
        addSubview(titleMars)
    }
    
    // MARK: Створення лейблу для відображення поточної дати
    private func createDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.customFont
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let textDate = formatter.string(from: Date.now)
        dateLabel.text = textDate
        dateLabel.textColor = .projectBlack
        addSubview(dateLabel)
    }
    
    // MARK: Створення кнопки для відображення календаря
    private func createCalendarButton() {
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "calendar")
        calendarButton.setImage(image, for: .normal)
        calendarButton.imageView?.contentMode = .scaleAspectFit
        calendarButton.contentVerticalAlignment = .fill
        calendarButton.contentHorizontalAlignment = .fill
        calendarButton.backgroundColor = .clear
        calendarButton.addTarget(self, action: #selector(calendarViewIsVisible), for: .touchUpInside)
        addSubview(calendarButton)
    }
    
    // MARK: Створення кнопки для фільтрації за ровером
    private func creatFilterRoverButton() {
        filterRoverButton.translatesAutoresizingMaskIntoConstraints = false
        filterRoverButton.setupButton(image: "rover")
        filterRoverButton.addTarget(self, action: #selector(roverViewIsVisible), for: .touchUpInside)
        addSubview(filterRoverButton)
    }
    
    // MARK: Створення кнопки для фільтрації за камерою
    private func createFilterCameraButton() {
        filterCameraButton.translatesAutoresizingMaskIntoConstraints = false
        filterCameraButton.setupButton(image: "camera")
        filterCameraButton.addTarget(self, action: #selector(cameraViewIsVisible), for: .touchUpInside)
        addSubview(filterCameraButton)
    }
    
    // MARK: Створення кнопки для збереження фільтрів
    private func createSaveFilterButton() {
        saveFilterButton.translatesAutoresizingMaskIntoConstraints = false
        saveFilterButton.clipsToBounds = true
        saveFilterButton.layer.cornerRadius = 10
        saveFilterButton.backgroundColor = .white
        let image = UIImage(named: "addFilter")
        saveFilterButton.setImage(image, for: .normal)
        saveFilterButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 26, leading: 26, bottom: 26, trailing: 26)
        addSubview(saveFilterButton)
        
    }
    
    // MARK: Налаштування констрейнтів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            
            self.heightAnchor.constraint(equalTo: initView.viewController.heightAnchor, multiplier: 0.17),
            self.topAnchor.constraint(equalTo: initView.viewController.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: initView.viewController.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: initView.viewController.trailingAnchor),
            
            
            titleMars.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            titleMars.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            titleMars.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            titleMars.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
           
            dateLabel.topAnchor.constraint(equalTo: titleMars.bottomAnchor, constant: 2),
            dateLabel.leadingAnchor.constraint(equalTo: titleMars.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.48),
            dateLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            
            calendarButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.08),
            calendarButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.23),
            calendarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            calendarButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            
            filterRoverButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 22),
            filterRoverButton.leadingAnchor.constraint(equalTo: titleMars.leadingAnchor),
            filterRoverButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            filterRoverButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.36),
            
            
            filterCameraButton.topAnchor.constraint(equalTo: filterRoverButton.topAnchor),
            filterCameraButton.leadingAnchor.constraint(equalTo: filterRoverButton.trailingAnchor, constant: 12),
            filterCameraButton.widthAnchor.constraint(equalTo: filterRoverButton.widthAnchor),
            filterCameraButton.heightAnchor.constraint(equalTo: filterRoverButton.heightAnchor),
            
            saveFilterButton.leadingAnchor.constraint(equalTo: filterCameraButton.trailingAnchor, constant: 23),
            saveFilterButton.topAnchor.constraint(equalTo: filterRoverButton.topAnchor),
            saveFilterButton.widthAnchor.constraint(equalTo: filterRoverButton.heightAnchor),
            saveFilterButton.heightAnchor.constraint(equalTo: filterRoverButton.heightAnchor),
            
        ])
    }
    
    // MARK: - Обробники натискання кнопок
    @objc func calendarViewIsVisible() {
        delegate?.changeHidenCalendarView(isHeadenView: false)
    }
    
    @objc func cameraViewIsVisible() {
       delegate?.changeHidenCameraView(isHeadenView: false)
    }
    
    @objc func roverViewIsVisible() {
       delegate?.changeHidenRoverView(isHeadenView: false)
    }
}







