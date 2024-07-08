//
//  HomeViewController.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import UIKit


class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    //MARK: Колекція для відображення фотографій
    private var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 20, left: 20, bottom: 5, right: 20)
        layout.collectionView?.clipsToBounds = true
        layout.itemSize = .init(width: 353, height: 150)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    //MARK: Інші UI елементи
    private let headerCollectionView = HeaderCollectionView()
    private let dateView = CustomDateView()
    lazy var cameraFilterView = CustomPickerView(viewData: .init(centerLabelText: "Camera"))
    lazy var rovarFilterView = CustomPickerView(viewData: .init(centerLabelText: "Rover"))
    private let historyButton = HistoryCustomButton()
    private var loyerView = UIView()
    
    //MARK: Масиви для фільтрації фотографій
    private var filterCard = [Photo]()
    let pickerArray = PickerModelView()
    var photoArray = [Photo]()
    var selectedRover = "all"
    var selectedCamera = "all"
    var selectedDate: String = ""
    
    var detailViewController: DetailImageViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .projectWhite
        updateNavigation()
        
        createHistoryButton()
        createCollectionView()
        createHeaderView()
        createDateView()
        createLoyerView()
        createCameraFilterView()
        createRoverFilterView()
        makeConstraints()
        fetchPhotos()
        
        
        
        
        
    }
    
    // MARK: - UI Creation
    
    //MARK: Налаштування навігаційного бару
    private func updateNavigation() {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Створення колекції для відображення фотографій
    private func createCollectionView() {
        cardCollectionView.backgroundColor = .white
        cardCollectionView.layer.shadowRadius = 10
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        cardCollectionView.reloadData()
        cardCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "\(CardCollectionViewCell.self)")
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardCollectionView)
    }
    
    //MARK: Створення хедера
    private func createHeaderView() {
        headerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        headerCollectionView.delegate = self
        self.view.addSubview(headerCollectionView)
    }
    
    //MARK: Створення view для затемнення
    private func createLoyerView() {
        loyerView = UIView(frame: self.view.bounds)
        loyerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        loyerView.isHidden = true
        self.view.addSubview(loyerView)
    }
    
    //MARK: Створення view для відображення календаря
    private func createDateView() {
        dateView.isHidden = true
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.clipsToBounds = true
        dateView.delegate = self
        self.view.addSubview(dateView)
    }
    
    //MARK: // Створення view для фільтрації за камерою
    private func createCameraFilterView() {
        cameraFilterView.isHidden = true
        cameraFilterView.translatesAutoresizingMaskIntoConstraints = false
        cameraFilterView.picker.delegate = self
        cameraFilterView.picker.dataSource = self
        cameraFilterView.delegate = self
        self.view.addSubview(cameraFilterView)
    }
    
    //MARK: // Створення view для фільтрації за ровером
    private func createRoverFilterView() {
        rovarFilterView.picker.dataSource = self
        rovarFilterView.picker.delegate = self
        rovarFilterView.isHidden = true
        rovarFilterView.translatesAutoresizingMaskIntoConstraints = false
        rovarFilterView.delegate = self
        self.view.addSubview(rovarFilterView)
    }
    
    //MARK: Створення кнопки історії
    private func createHistoryButton() {
        historyButton.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 44/255, alpha: 1)
        self.view.addSubview(historyButton)
    }
    
    //MARK: Налаштування констрейнтів для всіх UI елементів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            headerCollectionView.widthAnchor.constraint(equalToConstant: 393),
            headerCollectionView.heightAnchor.constraint(equalToConstant: 148),
            headerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            
            cardCollectionView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            cardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateView.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            dateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateView.heightAnchor.constraint(equalToConstant: 312),
            dateView.widthAnchor.constraint(equalToConstant: 353),
            
            cameraFilterView.widthAnchor.constraint(equalTo: view.widthAnchor),
            cameraFilterView.heightAnchor.constraint(equalToConstant: 306),
            cameraFilterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 546),
            
            rovarFilterView.widthAnchor.constraint(equalTo: view.widthAnchor),
            rovarFilterView.heightAnchor.constraint(equalToConstant: 306),
            rovarFilterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 546),
            
            historyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 761),
            historyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 303)
        ])
    }
    
    
    //MARK: - Фільтрація вмісту за обраними камерою та ровером
    private func filterContent() {
        filterContentForSearchText(cam: selectedCamera, rov: selectedRover)
    }
    
    func filterContentForSearchText(cam: String, rov: String) {
        if cam == "all" && rov == "all" {
            filterCard = photoArray.filter { $0.earthDate == selectedDate }
        } else {
            filterCard = photoArray.filter { (card: Photo) in
                
                let matchesCamera = selectedCamera.lowercased() == "all" || card.camera.fullName.lowercased() == cam.lowercased()
                let matchesRover = selectedRover.lowercased() == "all" || card.rover.name.lowercased() == rov.lowercased()
                let matchesDate = card.earthDate == selectedDate
                return matchesCamera && matchesRover && matchesDate
                
            }
        }
        cardCollectionView.reloadData()
    }
    
    // MARK: - Data Fetching
    
    //MARK: Завантаження фотографій з API NASA
    func fetchPhotos() {
        NasaApi.shared.getRovers { rovers in
            DispatchQueue.main.async {
                if let rovers = rovers {
                    self.pickerArray.rovers.append(contentsOf: rovers)
                    self.rovarFilterView.picker.reloadAllComponents()
                    self.pickerArray.cameras.append(contentsOf: rovers.flatMap { $0.cameras })
                    self.cameraFilterView.picker.reloadAllComponents()
                    NasaApi.shared.getAllPhotos(date: self.selectedDate) { allPhotos in
                        self.photoArray = allPhotos
                        self.filterContent()
                        print("Отримано \(allPhotos.count) фото за обраною датою")
                    }
                } else {
                    print("Не вдалося отримати дані про ровери")
                }
            }
            
        }
        
    }
}

// MARK: - Extensions

// MARK: Розширення для роботи з колекцією фотографій
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardCollectionViewCell.self)", for: indexPath) as? CardCollectionViewCell {
                cell.photo = filterCard[indexPath.item]
               return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let detailVC = DetailImageViewController()
               let selectedPhoto = filterCard[indexPath.item]
               detailVC.photoURL = selectedPhoto.imgSrc
            navigationController?.pushViewController(detailVC, animated: false)
    }
}

//MARK: Розширення для взаємодії з хедером
extension HomeViewController: HeaderCollectionViewDelegate {
   
    func changeHidenCalendarView(isHeadenView: Bool) {
        loyerView.isHidden = isHeadenView
        dateView.isHidden = isHeadenView
        self.view.bringSubviewToFront(dateView)
    }
    
    func changeHidenCameraView(isHeadenView: Bool) {
        cameraFilterView.isHidden = isHeadenView
    }
    
    func changeHidenRoverView(isHeadenView: Bool) {
        rovarFilterView.isHidden = isHeadenView
    }
}

//MARK: Розширення для взаємодії з календарем для вибору дати
extension HomeViewController: CustomDateViewDelegate {
    func didSelectDate(date: String) {
        selectedDate = date
    }
    
    func loyerIsHeaden(isHeaden: Bool) {
        loyerView.isHidden = isHeaden
    }
    
    func changeTitle(text: String) {
        headerCollectionView.dateLabel.text = text
    }
}

//MARK: Розширення для взаємодії з pickerView
extension HomeViewController: CustomPickerViewDelegate {
    func viewIsHeaden(isHeaden: Bool) {
        cameraFilterView.isHidden = isHeaden
        rovarFilterView.isHidden = isHeaden
    }
}


//MARK: Розширення для взаємодії з вибором фільтрів (камера та ровер)
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int 
    {
        switch pickerView {
        case cameraFilterView.picker:
            return pickerArray.cameras.count
        case rovarFilterView.picker:
            return pickerArray.rovers.count
        default:
            break
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textAlignment = .center
        var title = String()
        if pickerView == cameraFilterView.picker {
            title = pickerArray.cameras.map({ $0.fullName })[row]
        } else if pickerView == rovarFilterView.picker {
            title = pickerArray.rovers.map({ $0.name })[row]
        }
        
        let attributedTitle = NSMutableAttributedString(string: title)
        
        if row == 0 {
            attributedTitle.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: 18)
            ], range: NSRange(location: 0, length: title.count))
        } else {
            attributedTitle.addAttributes([
                .font: UIFont.systemFont(ofSize: 18)
            ], range: NSRange(location: 0, length: title.count))
        }
        
        label.attributedText = attributedTitle
        return label
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == cameraFilterView.picker {
                   return pickerArray.cameras[row].name
               } else if pickerView == rovarFilterView.picker {
                   return pickerArray.rovers[row].name
               }
               return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cameraFilterView.picker {
            selectedCamera = pickerArray.cameras.map({$0.fullName})[row]
            headerCollectionView.filterCameraButton.labelCustomButton.text = pickerArray.cameras.map({$0.name})[row]
        } else if pickerView == rovarFilterView.picker {
            selectedRover = pickerArray.rovers.map({$0.name})[row]
            headerCollectionView.filterRoverButton.labelCustomButton.text = pickerArray.rovers.map({$0.name})[row]
        }
        filterContent()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
