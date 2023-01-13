//
//  UICollectionView+extension.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(_ cellClass: T.Type, forSupplementaryViewOfKind elementKind: String) {
        let reuseIdentifier = cellClass.className
        register(cellClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as? T
    }

}
