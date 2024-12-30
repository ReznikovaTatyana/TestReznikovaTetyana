//
//  HomeColletionViewDataSourse.swift
//  TestReznikovaTetyana
//
//  Created by mac on 16.09.2024.
//

import Foundation
import UIKit

class HomeColletionViewDataSourse: NSObject, UICollectionViewDataSource {
    
    var dataSourse: [Photo] = []
    
    public func getDataSourse(photo: [Photo]) {
        dataSourse = photo
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourse.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardCollectionViewCell.self)", for: indexPath) as? CardCollectionViewCell {
                cell.configureCell(photo: dataSourse[indexPath.item])
               // cell.cardImageView.image = UIImage(named: dataSourse[indexPath.item].image)
               return cell
        }
        return UICollectionViewCell()
    }
    
  
    
   
}
