//
//  TabBarController.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    deinit {
        print("Tab Bar deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
    }
    
    func commonInit() {
        viewControllers = viewControllers()
        
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.black
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    func viewController<T: UIViewController>(type: T.Type, title: String?, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let viewController = T(nibName: nil, bundle: nil)
        let nvc = BaseNavigationController(rootViewController: viewController)
        let baseTabBarItem = BaseTabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        nvc.tabBarItem = baseTabBarItem
        return nvc
    }
    
    func viewControllers() -> [UIViewController] {
        let controllers = [
            viewController(type: ViewController.self, title: "Home",
                           image: UIImage(systemName: "house"),
                           selectedImage: UIImage(systemName: "house")),
            viewController(type: ViewController.self,
                           title: "Favorite", image: UIImage(systemName: "heart"),
                           selectedImage: UIImage(systemName: "heart"))
        ]
        
        return controllers
    }
}

