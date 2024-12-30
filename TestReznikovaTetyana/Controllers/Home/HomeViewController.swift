//
//  HomeViewController.swift
//  TestReznikovaTetyana
//
//  Created by mac on 04.07.2024.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    //MARK: Масиви для фільтрації фотографій
    let pickerArray = PickerModelView()
    var selectedRover = "All"
    var selectedCamera = "All"
    var selectedCameraHeaderText = "All"
    

    lazy var formattedDate = FormatterString.shared.formatterStringToDate(string: homeView.selectedDate)
    lazy var str = FormatterString.shared.formatterDateToFetchString(date: homeView.dateView.datePicker.date)
    
   // var detailViewController = DetailImageViewController()
    lazy var homeView: HomeView = HomeView(frame: .zero)
    lazy var homeModel = HomeModel()
    
    var collectionViewDataSourse = HomeColletionViewDataSourse()
    lazy var preloaderModel = PreloaderModel()
    
    override func loadView() {
        view = homeView
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .projectOrange
        navigationController?.isNavigationBarHidden = true
        homeView.configureCollection(dataSourse: collectionViewDataSourse, delegate: self)
        homeView.cameraFilterView.picker.delegate = self
        homeView.cameraFilterView.picker.dataSource = self
        homeView.cameraFilterView.delegate = self
        homeView.rovarFilterView.picker.delegate = self
        homeView.rovarFilterView.picker.dataSource = self
        homeView.rovarFilterView.delegate = self
       
        homeView.dateView.delegateApi = self
        photo()
        
        homeView.reloadCollectionView()
        
      
        print(str)
       
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func photo() {
        
        Task {
            do {
                let modelPhoto = try await homeModel.filterPickerArray(pickerModel: pickerArray, date: str, camera: selectedCamera, rover: selectedRover)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.homeView.addModelView(modelView: modelPhoto)
                    self.homeView.array(array: modelPhoto)
                    filterContent()
                    self.homeView.configureCollection(dataSourse: collectionViewDataSourse, delegate: self)
                    print(self.pickerArray.cameras.map({$0.name}))
                    print(modelPhoto.count)
                    print(selectedRover, selectedCamera)
                }
            }
            catch {
                print(Error.self)
            }
        }
        
        homeView.reloadCollectionView()
        
    }
    
    
    func filterContent() {
        DispatchQueue.global(qos: .userInitiated).async {
           let array = self.homeModel.filt(cam: self.selectedCamera, rov: self.selectedRover)
            DispatchQueue.main.async {
                self.collectionViewDataSourse.getDataSourse(photo: array)
                self.homeView.reloadCollectionView()

            }
        }

    }
    
}

// MARK: Розширення для роботи з колекцією фотографій
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  
    {
        let detailViewController = DetailImageViewController()
        let selectedPhoto = collectionViewDataSourse.dataSourse[indexPath.item].image
       // detailViewController.loadImage(from: selectedPhoto)
        detailViewController.photoURL = selectedPhoto
        print(selectedPhoto)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}

extension HomeViewController: DateGetApiDelegate  {
    func didSelectDate(date: String) {
        str = date
        photo()
    }
}




//MARK: Розширення для взаємодії з pickerView
extension HomeViewController: CustomPickerViewDelegate {
    func tickView(isHeaden: Bool) {
      
        homeView.cameraFilterView.isHidden = isHeaden
        homeView.headerCollectionView.filterCameraButton.labelCustomButton.text = selectedCameraHeaderText
       
        homeView.rovarFilterView.isHidden = isHeaden
        homeView.headerCollectionView.filterRoverButton.labelCustomButton.text = selectedRover
        filterContent()
        homeView.reloadCollectionView()
    }
    
    
    func closeView(isHeaden: Bool) {
        homeView.cameraFilterView.isHidden = isHeaden
        homeView.rovarFilterView.isHidden = isHeaden
    }
    
    func contentCollectionView() {
        homeView.cardCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
        case homeView.cameraFilterView.picker:
            return pickerArray.cameras.count
        case homeView.rovarFilterView.picker:
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
        if pickerView == homeView.cameraFilterView.picker {
            title = pickerArray.cameras.map({ $0.fullName })[row]
        } else if pickerView == homeView.rovarFilterView.picker {
            title = pickerArray.rovers[row]
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
        
        if pickerView == homeView.cameraFilterView.picker {
            return pickerArray.cameras[row].name
        } else if pickerView == homeView.rovarFilterView.picker {
            return pickerArray.rovers[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == homeView.cameraFilterView.picker {
            selectedCamera = pickerArray.cameras.map({$0.fullName})[row]
            selectedCameraHeaderText = pickerArray.cameras.map({$0.name})[row]
        } else if pickerView == homeView.rovarFilterView.picker {
               selectedRover = pickerArray.rovers[row]
            }
        }
        
        

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 40
        }
    }

