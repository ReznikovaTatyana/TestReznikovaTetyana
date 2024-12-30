//
//  HomeView.swift
//  TestReznikovaTetyana
//
//  Created by mac on 14.09.2024.
//

import Foundation
import UIKit


class HomeView: UIView {
  var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 20, left: 20, bottom: 5, right: 20)
       // layout.collectionView?.clipsToBounds = true
        layout.itemSize = .init(width: 353, height: 150)
        let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.backgroundColor = .white
        cardCollectionView.layer.shadowRadius = 10
        cardCollectionView.clipsToBounds = true
        cardCollectionView.reloadData()
        cardCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "\(CardCollectionViewCell.self)")
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return cardCollectionView
    }()
    
    lazy var emptyView = EmptyView(viewData: .init(viewController: self, loaderIsHeaden: true, labelIsHeaden: false))
    lazy var loaderView  = EmptyView(viewData: .init(viewController: self, loaderIsHeaden: false, labelIsHeaden: true))
    
    //MARK: Інші UI елементи
    lazy var headerCollectionView: HeaderCollectionView = {
        let header =  HeaderCollectionView(initView: .init(viewController: self))
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var dateView = CustomDateView(initView: .init(viewController: self))
    lazy var cameraFilterView = CustomPickerView(viewData: .init(centerLabelText: "Camera", viewController: self))
    lazy var rovarFilterView = CustomPickerView(viewData: .init(centerLabelText: "Rover", viewController: self))
    private let historyButton = HistoryCustomButton()
    private var loyerView = UIView()
    
    //MARK: Масиви для фільтрації фотографій

    var selectedDate = String()
    var detailViewController = DetailImageViewController()
    weak var homeViewController: HomeViewController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        headerCollectionView.delegate = self
        addToView()
        createHistoryButton()
        createDateView()
        createLoyerView()
        createCameraFilterView()
        createRoverFilterView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addToView() {
        self.addSubview(cardCollectionView)
        self.addSubview(headerCollectionView)
        self.addSubview(emptyView)
        //emptyView.isHidden = true
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .white
    }
    
    
    //MARK: Створення view для затемнення
    private func createLoyerView() {
        loyerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        loyerView.isHidden = true
        loyerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loyerView)
    }
    
    //MARK: Створення view для відображення календаря
    private func createDateView() {
        dateView.isHidden = true
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.clipsToBounds = true
        dateView.delegate = self
        self.addSubview(dateView)
    }
    
    //MARK: // Створення view для фільтрації за камерою
    private func createCameraFilterView() {
        cameraFilterView.isHidden = true
        cameraFilterView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cameraFilterView)
    }
    
    
    
    //MARK: // Створення view для фільтрації за ровером
    private func createRoverFilterView() {
        rovarFilterView.isHidden = true
        rovarFilterView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rovarFilterView)
    }
    
    //MARK: Створення кнопки історії
    private func createHistoryButton() {
        historyButton.backgroundColor = .projectOrange
        self.addSubview(historyButton)
    }
    
    //MARK: Налаштування констрейнтів для всіх UI елементів
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cardCollectionView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            cardCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cardCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
          
          
            loyerView.topAnchor.constraint(equalTo: self.topAnchor),
            loyerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loyerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loyerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    
    private func animatedCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             self.cardCollectionView.reloadData()
            let cells = self.cardCollectionView.visibleCells
            let collectionViewHeight = self.cardCollectionView.bounds.height
            var delay: Double = 0
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: collectionViewHeight)
                
                UIView.animate(withDuration: 1.5,
                               delay: delay * 0.05,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut) {
                    cell.transform = CGAffineTransform.identity
                }
                delay += 1
            }
        }
    }
    
   public func reloadCollectionView() {
        cardCollectionView.reloadData()
    }
    
    public func array(array: [Photo]) {
        if array.isEmpty {
            cardCollectionView.isHidden = true
            emptyView.isHidden = false
        } else if !array.isEmpty {
            cardCollectionView.isHidden = false
            emptyView.isHidden = true
        }
    }
    
    public func configureCollection(dataSourse: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        cardCollectionView.dataSource = dataSourse
        cardCollectionView.delegate = delegate
    }
    
    public func addModelView(modelView: [Photo]) {
        cameraFilterView.picker.reloadAllComponents()
        rovarFilterView.picker.reloadAllComponents()
    }
    
    
}


//MARK: Розширення для взаємодії з хедером
extension HomeView: HeaderCollectionViewDelegate {
   
    func changeHidenCalendarView(isHeadenView: Bool) {
        loyerView.isHidden = isHeadenView
        dateView.isHidden = isHeadenView
        self.bringSubviewToFront(dateView)
    }
    
    func changeHidenCameraView(isHeadenView: Bool) {
        cameraFilterView.isHidden = isHeadenView
        
    }
    
    func changeHidenRoverView(isHeadenView: Bool) {
        rovarFilterView.isHidden = isHeadenView
       
    }
}

extension HomeView: CustomDateViewDelegate {
    func didSelectDate(date: String) {
        selectedDate = date
        cardCollectionView.reloadData()
        cardCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func loyerIsHeaden(isHeaden: Bool) {
        loyerView.isHidden = isHeaden
    }
    
    func changeTitle(text: String) {
        headerCollectionView.dateLabel.text = text
    }
    

}

