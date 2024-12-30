//
//  CustomDateView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import Foundation
import UIKit

//MARK: Протокол для делегата, який надає методи для зміни видимості loyerView та зміни зоголовка дати в хедері
protocol CustomDateViewDelegate: AnyObject {
    func changeTitle(text: String)
    func loyerIsHeaden(isHeaden: Bool)
    func didSelectDate(date: String)
}

protocol DateGetApiDelegate: AnyObject {
    func didSelectDate(date: String)
}

class CustomDateView: UIView {
    
    // MARK: - Properties
    let datePicker = UIDatePicker()
    let closeButton = UIButton(type: .custom)
    let tickButton = UIButton(type: .custom)
    let dateLabel = UILabel()
    weak var delegate: CustomDateViewDelegate?
    weak var delegateApi: DateGetApiDelegate?
  
    
  
    struct InitView {
        let viewController: UIView
    }
    private var initView: InitView
    
    
    // MARK: - Initialization
    init(initView: InitView) {
        self.initView = initView
        super.init(frame: .zero)
        initView.viewController.addSubview(self)
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
        self.translatesAutoresizingMaskIntoConstraints = false
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
            
            self.centerXAnchor.constraint(equalTo: initView.viewController.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: initView.viewController.centerYAnchor),
            self.widthAnchor.constraint(equalTo: initView.viewController.widthAnchor, multiplier: 0.9),
            self.heightAnchor.constraint(equalTo: initView.viewController.heightAnchor, multiplier: 0.36),
            
            closeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.14),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            tickButton.heightAnchor.constraint(equalTo: closeButton.heightAnchor),
            tickButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor),
            tickButton.topAnchor.constraint(equalTo: closeButton.topAnchor),
            tickButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            dateLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09),
            dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.23),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.68)
        ])
    }
    
    //MARK: Обробник натискання кнопки закриття
    @objc func closeView() {
        self.isHidden = true
        delegate?.loyerIsHeaden(isHeaden: true)
    }
    
    //MARK: Обробник натискання кнопки підтвердження вибору
    @objc func changeTitle() {
        let pickerTextDate = FormatterString.shared.formatterDateToFetchString(date: datePicker.date)
        let textDate = FormatterString.shared.formatterDateToTitleString(date: datePicker.date)
        delegate?.changeTitle(text: textDate)
        delegate?.loyerIsHeaden(isHeaden: true)
        delegateApi?.didSelectDate(date: pickerTextDate)
        self.isHidden = true
        
    }
}



