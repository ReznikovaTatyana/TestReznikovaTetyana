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
    var delegate: HeaderCollectionViewDelegate?
    
 
    // MARK: - Ініціалізація
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        titleMars.font = UIFont.boldSystemFont(ofSize: 34)
        titleMars.text = "MARS.CAMERA"
        titleMars.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        addSubview(titleMars)
    }
    
    // MARK: Створення лейблу для відображення поточної дати
    private func createDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let textDate = formatter.string(from: Date.now)
        dateLabel.text = textDate
        dateLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        addSubview(dateLabel)
    }
    
    // MARK: Створення кнопки для відображення календаря
    private func createCalendarButton() {
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "calendar")
        calendarButton.setImage(image, for: .normal)
        calendarButton.imageView?.contentMode = .scaleAspectFill
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
            titleMars.widthAnchor.constraint(equalToConstant: 245),
            titleMars.heightAnchor.constraint(equalToConstant: 42),
            titleMars.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            titleMars.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            
            dateLabel.widthAnchor.constraint(equalToConstant: 187),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            
            calendarButton.widthAnchor.constraint(equalToConstant: 30),
            calendarButton.heightAnchor.constraint(equalToConstant: 34),
            calendarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 332),
            calendarButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            
            filterRoverButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            filterRoverButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            
            filterCameraButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            filterCameraButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 172),
            
            saveFilterButton.widthAnchor.constraint(equalToConstant: 38),
            saveFilterButton.heightAnchor.constraint(equalToConstant: 38),
            saveFilterButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            saveFilterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 335)
    
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







