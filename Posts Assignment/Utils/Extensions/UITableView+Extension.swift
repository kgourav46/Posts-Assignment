//
// UITableView+Extension.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import UIKit


extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}
