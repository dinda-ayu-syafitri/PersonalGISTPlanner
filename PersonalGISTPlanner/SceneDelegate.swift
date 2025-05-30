//
//  SceneDelegate.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 17/05/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let splashVC = UIStoryboard(name: "SplashScreen", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenView")

        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UITabBarController

            let dashboardVC = UIStoryboard(name: "DashboardView", bundle: nil).instantiateViewController(withIdentifier: "DashboardView")
            dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house.fill"), tag: 1)

            let inputVC = UIStoryboard(name: "InputView", bundle: nil).instantiateViewController(withIdentifier: "InputNavView")
            inputVC.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.square.fill"), tag: 2)

            let goalsVC = UIStoryboard(name: "GoalsView", bundle: nil).instantiateViewController(withIdentifier: "GoalsNavView")
            goalsVC.tabBarItem = UITabBarItem(title: "Goals", image: UIImage(systemName: "target"), tag: 3)

            let planBasketVC = UIStoryboard(name: "PlanBasketView", bundle: nil).instantiateViewController(withIdentifier: "PlanBasketNavView")
            planBasketVC.tabBarItem = UITabBarItem(title: "Plan Basket", image: UIImage(systemName: "basket.fill"), tag: 4)

            tabBarController.viewControllers = [dashboardVC, inputVC, goalsVC, planBasketVC]

            UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.window?.rootViewController = tabBarController
            })
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
