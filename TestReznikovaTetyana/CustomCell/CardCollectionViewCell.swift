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
    let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .projectGrey
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var homeCellModel: HomeCellModel = HomeCellModel()
    
//    var photo: Photo? {
//            didSet {
//                configureCell()
//            }
//        }
//   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForReuse()
        setupUI()
        createCarsImageView()
        createLabels()
        makeConstraints()
        //addLoader(loader: loader, imageView: cardImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            cardImageView.image = nil // Очищення попереднього зображення
            roverLabel.text = nil
            cameraLabel.text = nil
            dateLabel.text = nil
 
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
        cardImageView.image = nil
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardImageView)
        cardImageView.addSubview(loader)
    }
    
    private func createLabels() {
        upgrateLabels(label: roverLabel)
        upgrateLabels(label: cameraLabel)
        upgrateLabels(label: dateLabel)
    }
    
    // MARK: Налаштування для всіх лейблів
    private func upgrateLabels(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
       
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
            
            dateLabel.heightAnchor.constraint(equalToConstant: 42),
            dateLabel.widthAnchor.constraint(equalToConstant: 187),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 101),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            loader.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor),
        ])
        
    }
    
//    
//    func addLoader(loader: UIActivityIndicatorView, imageView: UIImageView) {
//            guard let photo = photo else { return }
//            addAttributedText(photo: photo)
//            guard let url = URL(string: photo.image) else {return}
//                loader.startAnimating()
//                NasaApi.shared.loadImage(url: url, imageView: imageView) { [weak self] image in
//                    guard let self = self else {return}
//                    DispatchQueue.main.async  {
//                        loader.stopAnimating()
//                        if self.photo?.image == photo.image {
//                            imageView.image = image
//                                    }
//            }
//            }
//    
//        }
    
    
    // MARK: Налаштування ячейки з отриманами данними з Api
    func configureCell(photo: Photo) {
        addAttributedText(photo: photo)
        guard let url = URL(string: photo.image) else {return}
            loader.startAnimating()
        
        Task {
            let image = try? await ImageService.downloadImage(urlString: photo.image)
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                    self.cardImageView.image = image
            }
            
        }
            
    }
    
    private func addAttributedText(photo: Photo) {
        let stringRoverName = FormatterString.shared.formatterString(string: photo.earthDate)
            roverLabel.attributedText = DisineString.shared.roverLabel(textApi: photo.rover.name)
            cameraLabel.attributedText = DisineString.shared.cameraLabel(textApi: photo.camera.fullName)
            dateLabel.attributedText = DisineString.shared.dateLabel(textApi: stringRoverName)
       
    }
 
}

 
