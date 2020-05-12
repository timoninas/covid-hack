//
//  SceneDelegate.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let windowScene = scene as! UIWindowScene
        let window = UIWindow(windowScene: windowScene)
        
        // MARK:-MapVC
        let mapVC = UIViewController()
        // TabBarItem for MapVC
        guard let mapDataImg = UIImage(named: "map")?.pngData() else { return }
        let mapImg =  UIImage(data: mapDataImg, scale: 7.5)//
        let mapBarItem = UITabBarItem(title: "", image: mapImg, selectedImage: nil)
        mapVC.tabBarItem = mapBarItem
        
        
        // MARK:-StatsVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let statsVC = storyboard.instantiateViewController(identifier: "ViewController")
        let statNavController = UINavigationController(rootViewController: statsVC)
        // TabBarItem for StatsVC
        guard let statsDataImg = UIImage(named: "stats")?.pngData() else { return }
        let statImg =  UIImage(data: statsDataImg, scale: 7.5)//
        let statBarItem = UITabBarItem(title: "", image: statImg, selectedImage: nil)
        statsVC.tabBarItem = statBarItem
        
        
        // MARK:-TestVC
        let testVC = TestViewController()
//      let secondNav = UINavigationController(rootViewController: testVC)
        guard let testDataImg = UIImage(named: "test")?.pngData() else { return }
        // TabBarItem for TestVC
        let testImg =  UIImage(data: testDataImg, scale: 7)//
        let testBarItem = UITabBarItem(title: "", image: testImg, selectedImage: nil)
        testVC.tabBarItem = testBarItem
        
        
        // MARK:- Setup NavBar
        let tabBar = UITabBarController()
        tabBar.setViewControllers([mapVC, statNavController, testVC], animated: true)
        tabBar.selectedViewController = statNavController
        window.rootViewController = tabBar
        
        window.backgroundColor = .white
        self.window = window
        window.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

