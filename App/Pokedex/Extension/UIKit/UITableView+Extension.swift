//
//  UITableView+Extension.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/31.
//

import Foundation

import UIKit

extension UITableView {
  
  func registerXib<T:UITableViewCell>(of cellClass: T.Type) {
    let className = cellClass.className
    let nib: UINib? = UINib(nibName: className, bundle: Bundle(for: cellClass))
    register(nib, forCellReuseIdentifier: className)
  }
  
  func dequeueCell<T:UITableViewCell>(of cellClass: T.Type, for indexPath: IndexPath) -> T {
    let className = cellClass.className
    guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
      fatalError()
    }
    
    return cell
  }
}
