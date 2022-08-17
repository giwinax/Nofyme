//
//  UIViewControllerExtension.swift
//  Nofyme (iOS)
//
//  Created by s b on 17.08.2022.
//

import UIKit
import SwiftUI

extension UIViewController {

    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
    func addAlertWithTextField(textFieldtext: String, alert: UIAlertController, completion: @escaping (UIAlertAction) -> Void) {
        let alert = alert
        alert.addTextField { (textField) in
            textField.text = textFieldtext
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
