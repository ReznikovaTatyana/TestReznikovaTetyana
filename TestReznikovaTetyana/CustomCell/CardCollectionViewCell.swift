//
//  CardCollectionViewCell.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let cardImageView = UIImageView()
    let roverLabel = UILabel()
    let cameraLabel = UILabel()
    let dateLabel = UILabel()
    
    var photo: Photo? {
            didSet {
                configureUI()
            }
        }
    
//    var array: Photo? {
//        didSet {
//            if let camera = array?.camera {
//                cameraLabel.text = "Camera: " + "\(camera)"
//            }
//            if  let rover = array?.rover {
//                roverLabel.text = "Rover: " + "\(rover)"
//            }
//            if let date = array?.earthDate {
//                dateLabel.text = "Date: " + "\(date)"
//            }
//            if let image = array?.imgSrc {
//                cardImageView.image = UIImage(named: image)
//            }
//             
//        }
   // }
   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        createCarsImageView()
        createLabels()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - UI Setup
    
    // MARK: Налаштувати зовнішнього вигляду ячейки
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 30.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.shadowRadius = 16
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 0.0
    }
    
    // MARK: Налаштування зображення
    private func createCarsImageView() {
        cardImageView.clipsToBounds = true
        cardImageView.layer.cornerRadius = 20
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardImageView)
    }
    
    private func createLabels() {
        upgrateLabels(label: roverLabel)
        upgrateLabels(label: cameraLabel)
        upgrateLabels(label: dateLabel)
    }
    
    // MARK: Налаштування для всіх лейблів
    private func upgrateLabels(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .projectLightGrey
        contentView.addSubview(label)
    }
    
    //MARK: Налаштування констрейнтів для всіх UI елементів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.heightAnchor.constraint(equalToConstant: 130),
            cardImageView.widthAnchor.constraint(equalToConstant: 130),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 213),
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            roverLabel.heightAnchor.constraint(equalToConstant: 21),
            roverLabel.widthAnchor.constraint(equalToConstant: 187),
            roverLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            roverLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            cameraLabel.heightAnchor.constraint(equalToConstant: 42),
            cameraLabel.widthAnchor.constraint(equalToConstant: 187),
            cameraLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 53),
            cameraLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
            dateLabel.widthAnchor.constraint(equalToConstant: 187),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 101),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
    }
    
    
    // MARK: Налаштування ячейки з отриманами данними з Api
    private func configureUI() {
           guard let photo = photo else { return }
        roverLabel.text =  "Rover: " + "\(photo.rover.name)"
        cameraLabel.text = "Camera: " + "\(photo.camera.fullName)"
        dateLabel.text =  "Date: " + "\(photo.earthDate)"
            if let url = URL(string: photo.imgSrc) {
                self.downloadImage(from: url) { image in
                    DispatchQueue.main.async {
                    self.cardImageView.image = image
                }
            }
        }
    }
   
    // MARK: - Завантаження зображення
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            let cacheKey = url.absoluteString
            if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
                print("Зображення знайдено у кеші для ключа: \(cacheKey)")
                completion(cachedImage)
                return
            }
        print("Зображення не знайдено у кеші, завантаження з: \(url.absoluteString)")
            
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(nil)
                return
            }
            components.scheme = "https"
            
            guard let secureURL = components.url else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: secureURL) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                print("Завантажено зображення, збереження у кеш для ключа: \(cacheKey)")
                ImageCache.shared.setImage(image, forKey: cacheKey)
                completion(image)
            }
            task.resume()
        }

}

 
