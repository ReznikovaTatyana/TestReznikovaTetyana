//
//  CustomDateView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import Foundation
import UIKit

//MARK: Протокол для делегата, який надає методи для зміни видимості loyerView та зміни зоголовка дати в хедері
protocol CustomDateViewDelegate {
    func changeTitle(text: String)
    func loyerIsHeaden(isHeaden: Bool)
    func didSelectDate(date: String)
}

class CustomDateView: UIView {
    
    // MARK: - Properties
    let datePicker = UIDatePicker()
    let closeButton = UIButton(type: .custom)
    let tickButton = UIButton(type: .custom)
    let dateLabel = UILabel()
    var delegate: CustomDateViewDelegate?
    
  
    // MARK: - Initialization
    init() {
         super.init(frame: .zero)
         setupUI()
         createDatePicker()
         createDateLabel()
         createCloseButton()
         createTickButton()
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
   
    //MARK: Створення пікера дати
    private func createDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.addSubview(datePicker)
        
    }
    
    //MARK: Створення лейбла для відображення тексту "Date"
    private func createDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "Date"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dateLabel.textAlignment = .center
        self.addSubview(dateLabel)
        
    }
    
    //MARK: Створення кнопки закриття
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
   
    //MARK:  Створення кнопки підтвердження вибору
    private func createTickButton() {
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Tick")
        tickButton.setImage(image, for: .normal)
        tickButton.imageView?.contentMode = .scaleAspectFill
        tickButton.contentVerticalAlignment = .fill
        tickButton.contentHorizontalAlignment = .fill
        tickButton.backgroundColor = .clear
        tickButton.addTarget(self, action: #selector(changeTitle), for: .touchUpInside)
        self.addSubview(tickButton)
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
            tickButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 289),
            
            dateLabel.heightAnchor.constraint(equalToConstant: 28),
            dateLabel.widthAnchor.constraint(equalToConstant: 81),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 136),
            
            datePicker.widthAnchor.constraint(equalToConstant: 297),
            datePicker.heightAnchor.constraint(equalToConstant: 212),
            datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
        ])
    }
    
    //MARK: Обробник натискання кнопки закриття
    @objc func closeView() {
        self.isHidden = true
        delegate?.loyerIsHeaden(isHeaden: true)
    }
    
    //MARK: Обробник натискання кнопки підтвердження вибору
    @objc func changeTitle() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let pickerTextDate = formatter.string(from: datePicker.date)
        delegate?.changeTitle(text: pickerTextDate)
        delegate?.loyerIsHeaden(isHeaden: true)
        delegate?.didSelectDate(date: pickerTextDate)
        self.isHidden = true
        
    }
}



