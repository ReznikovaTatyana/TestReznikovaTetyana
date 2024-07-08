//
//  DetailImageViewController.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    // MARK: - Properties
    let closeButton = UIButton(type: .custom)
    var photoImageView = UIImageView()
    var scrollView = UIScrollView()
    var initialImageViewSize: CGSize = CGSize(width: 393, height: 393)
    var photoURL: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createCloseButton()
        createCarsImageView()
        createScrollView()
        addDoubleTapGestureRecognizer()
        makeConstraints()
        self.view.bringSubviewToFront(closeButton)
        if let photoURL = photoURL {
                   loadImage(from: photoURL)
               }
    }
    
    // MARK: - UI Creation
    
    // MARK: Створення scroll view
    private func createScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 6.0
            scrollView.delegate = self
            view.addSubview(scrollView)
    }
    
    // MARK:  Створення кнопки закриття
    private func createCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "closeImage")
        closeButton.setImage(image, for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFill
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.backgroundColor = .clear
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    // MARK: Створення віджету для відображення фотографії
    private func createCarsImageView() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(photoImageView)
    }
    

    // MARK: Налаштування констрейнтів для UI елементів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 393),
            photoImageView.widthAnchor.constraint(equalToConstant: 393),
            photoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                       
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    // MARK:  Додавання розпізнавача подвійного натискання для збільшення фотографії
    private func addDoubleTapGestureRecognizer() {
            let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
            doubleTapRecognizer.numberOfTapsRequired = 2
            scrollView.addGestureRecognizer(doubleTapRecognizer)
        }
        
    // MARK: Обробник подвійного натискання для масштабування фотографії
        @objc private func handleDoubleTap() {
            if scrollView.zoomScale == scrollView.minimumZoomScale {
                scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
            } else {
                scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            }
        }
    // MARK: Обробник натискання кнопки закриття
    @objc func closeView() {
        navigationController?.popViewController(animated: false)
    }
    
    
    // MARK:  Завантаження фотографії з вказаного URL
    private func loadImage(from urlString: String) {
            let httpsURLString = urlString.replacingOccurrences(of: "http://", with: "https://")
            guard let url = URL(string: httpsURLString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
            task.resume()
        }
}

// MARK: - Extensions

//MARK: Розширення для роботи з масштабуванням в scroll view
extension DetailImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return photoImageView
        }
}

