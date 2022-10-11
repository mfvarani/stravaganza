//
//  RideTabBarViewController.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 09/10/2022.
//

import UIKit

class RideTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setupNavigationBarStyle()
        setupViewControllers()
        setupTabBarStyle()
    }
    
    private func setupViewControllers() {
        let rideViewController = UINavigationController(rootViewController: RideBaseViewController())
        let progressViewController = UINavigationController(rootViewController: ProgressTableViewController())
        
        rideViewController.title = Constants.rideTitle
        progressViewController.title = Constants.progressTitle
        
        setViewControllers([rideViewController, progressViewController], animated: false)
    }
    
    private func setupTabBarStyle() {
        guard let items = tabBar.items else { return }
        items[0].image = Constants.rideImage
        items[1].image = Constants.progressImage
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarAppearance.backgroundColor = .white
        
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.abelRegular(size: 14.0)
        ]
        
        tabBarItemAppearance.selected.iconColor = Constants.selectedTabBarItemColor
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.selectedTabBarItemColor,
        ]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func setupNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.viewBackgroundColor
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.abelRegular(size: 24.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func setupConstraints() {
        
    }
}

// MARK: - Constants

extension RideTabBarViewController {
    
    enum Constants {
        static let viewBackgroundColor = UIColor(red: 1, green: 0.557, blue: 0.145, alpha: 1)
        static let selectedTabBarItemColor = UIColor(red: 1, green: 0.557, blue: 0.145, alpha: 1)
        static let rideTitle = "My Ride"
        static let progressTitle = "My Progress"
        static let rideImage = UIImage(named: "figure.outdoor.cycle")
        static let progressImage = UIImage(named: "list.bullet.clipboard")
    }
}
