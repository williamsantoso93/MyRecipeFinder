//
//  Extension.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 08/06/21.
//

import UIKit

extension UIImageView {
    func load(url: URL, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completionHandler(true)
                    }
                }
            }
        }
    }
}
