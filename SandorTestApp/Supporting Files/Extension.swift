//
//  Extension.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
}
    
    func showAlert(title: String = "Alert", message: String) {
        if !message.isEmpty {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension String {
    
    func getURL() -> URL {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    func getImageFromStringUrl() -> UIImage? {
        guard let url = URL(string: self),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }

    func checkMaxCharacters(maxChar: Int = 20, text: String = "The searched phrase") -> String {
        return (self.characters.count) <= maxChar ? "" : text + " can contain only \(maxChar) characters"
    }
    
}
