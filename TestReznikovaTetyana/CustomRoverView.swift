////
////  CustomRoverView.swift
////  TestReznikovaTetyana
////
////  Created by mac on 05.07.2024.
////
//
//import Foundation
//import UIKit
//
//protocol CustomRoverViewDelegate {
//    func changeTitleRover(text: String)
//    func viewRoverIsHeaden(isHeaden: Bool)
//}
//
//class CustomRoverView: UIView {
//    
//    let closeButton = UIButton(type: .custom)
//    let tickButton = UIButton(type: .custom)
//    let roverLabel = UILabel()
//    let roverPicker = UIPickerView()
//    var delegate: CustomRoverViewDelegate?
//    
//  
//   
//        private var selectedRover: String?
//        
//    
//    
//    init() {
//        super.init(frame: .zero)
//        setupUI()
//        createCloseButton()
//        createTickButton()
//        createCameraLabel()
//       // createAllLabel()
//        createCameraPicker()
//        makeConstraints()
//       // selectedCamera = cameras.first
//    }
//    
//   
//   required init?(coder: NSCoder) {
//       fatalError("init(coder:) has not been implemented")
//   }
//    
//    private func setupUI() {
//        self.backgroundColor = .white
//        self.clipsToBounds = true
//        self.layer.cornerRadius = 50
//        self.layer.shadowColor = UIColor.black.cgColor
//        
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 16
//        self.layer.shadowOpacity = 0.08
//        self.layer.masksToBounds = false
//        self.layer.borderWidth = 0.0
//    }
//   
//    private func createCloseButton() {
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "closeView")
//        closeButton.setImage(image, for: .normal)
//        closeButton.imageView?.contentMode = .scaleAspectFill
//        closeButton.contentVerticalAlignment = .fill
//        closeButton.contentHorizontalAlignment = .fill
//        closeButton.backgroundColor = .clear
//        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
//        self.addSubview(closeButton)
//    }
//    
//    private func createTickButton() {
//        tickButton.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "Tick")
//        tickButton.setImage(image, for: .normal)
//        tickButton.imageView?.contentMode = .scaleAspectFill
//        tickButton.contentVerticalAlignment = .fill
//        tickButton.contentHorizontalAlignment = .fill
//        tickButton.backgroundColor = .clear
//        tickButton.addTarget(self, action: #selector(tickButtonTapped), for: .touchUpInside)
//        self.addSubview(tickButton)
//    }
//    
//    private func createCameraLabel() {
//        roverLabel.translatesAutoresizingMaskIntoConstraints = false
//        roverLabel.text = "Rover"
//        roverLabel.font = UIFont.boldSystemFont(ofSize: 22)
//        roverLabel.textAlignment = .center
//        self.addSubview(roverLabel)
//        
//    }
//    
//    private func createCameraPicker() {
//        roverPicker.translatesAutoresizingMaskIntoConstraints = false
//        roverPicker.tag = 1
//        roverPicker.delegate = self
//        roverPicker.dataSource = self
//        self.addSubview(roverPicker)
//    }
//    
//    private func makeConstraints() {
//        NSLayoutConstraint.activate([
//            self.widthAnchor.constraint(equalToConstant: 353),
//            self.heightAnchor.constraint(equalToConstant: 312),
//            
//            closeButton.heightAnchor.constraint(equalToConstant: 44),
//            closeButton.widthAnchor.constraint(equalToConstant: 44),
//            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            
//            tickButton.heightAnchor.constraint(equalToConstant: 44),
//            tickButton.widthAnchor.constraint(equalToConstant: 44),
//            tickButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            tickButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 329),
//            
//            roverLabel.heightAnchor.constraint(equalToConstant: 28),
//            roverLabel.widthAnchor.constraint(equalToConstant: 81),
//            roverLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
//            roverLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 156),
//            
//            roverPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            roverPicker.widthAnchor.constraint(equalToConstant: 353),
//            roverPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            roverPicker.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
//        ])
//        
//    }
//    
//    
//    @objc func closeView() {
//            self.isHidden = true
//        delegate?.viewRoverIsHeaden(isHeaden: true)
//        }
//        
//        @objc func tickButtonTapped() {
//            delegate?.changeTitleRover(text: selectedRover ?? "")
//            delegate?.viewRoverIsHeaden(isHeaden: true)
//            roverPicker.reloadAllComponents()
//            
//        }
//    
//    
//    
//}
//
//
//
//
//extension CustomRoverView: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return rovers.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//        
//        if let view = view as? UILabel {
//            label = view
//        } else {
//            label = UILabel()
//        }
//        
//        label.textAlignment = .center
//        let title = rovers[row]
//        let attributedTitle = NSMutableAttributedString(string: title)
//        
//        if row == 0 {
//            attributedTitle.addAttributes([
//                .font: UIFont.boldSystemFont(ofSize: 18)
//            ], range: NSRange(location: 0, length: title.count))
//        } else {
//            attributedTitle.addAttributes([
//                .font: UIFont.systemFont(ofSize: 18)
//            ], range: NSRange(location: 0, length: title.count))
//        }
//        
//        label.attributedText = attributedTitle
//        return label
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let cameraName =  rovers[row]
//        selectedRover = cameraName
//        return cameraName
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedRover = rovers[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 40
//    }
//}
