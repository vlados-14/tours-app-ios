//
//  SceneDelegate.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 27.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        NotificationCenter.default.addObserver (self, selector: #selector(self.onOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        window?.makeKeyAndVisible()
    }
    
    @objc func onOrientationChange() {
        if UIDevice.current.orientation == .portrait {
            let viewController = ToursListContainerVC(reactor: ToursContainerReactor())
            let navController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navController
        } else if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let landscapeController = LandscapeContainerVC()
            let navController = UINavigationController(rootViewController: landscapeController)
            window?.rootViewController = navController
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

