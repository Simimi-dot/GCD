//
//  SecondViewController.swift
//  GCD
//
//  Created by Егор Астахов on 12.11.2021.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированны?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { userNameTF in
            userNameTF.placeholder = "Введите логин"
        }
        ac.addTextField { userPasswordTF in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    
    
}

