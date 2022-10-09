//
//  OnboardingPageViewController.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 07/10/2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    // MARK: - Views
    
    var onboardingPages = [UIViewController]()
    let onboardingPageControl = UIPageControl()
    
    // MARK: - Properties
    
    private var isAnimating = false

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    // MARK: - Setup

    private func setup() {
        view.backgroundColor = Constants.viewBackgroundColor
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setupPages()
        setupPageControl()
    }
    
    private func setupPages() {
        let firstPageViewModel = OnboardingViewModel(image: Constants.easyImage,
                                                     text: Constants.easyText)
        let secondPageViewModel = OnboardingViewModel(image: Constants.trackerImage,
                                                     text: Constants.trackerText)
        let thirdPageViewModel = OnboardingViewModel(image: Constants.cyclingImage,
                                                     text: Constants.cyclingText)
        
        let firstPage = OnboardingBaseViewController(viewModel: firstPageViewModel)
        let secondPage = OnboardingBaseViewController(viewModel: secondPageViewModel)
        let thirdPage = OnboardingBaseViewController(viewModel: thirdPageViewModel)
        
        onboardingPages.append(contentsOf: [firstPage, secondPage, thirdPage])
        
        setViewControllers([onboardingPages[0]], direction: .forward, animated: false, completion: nil)
    }
    
    private func setupPageControl() {
        onboardingPageControl.addTarget(self, action: #selector(onboardingPageControlTapped(_:)), for: .valueChanged)
        onboardingPageControl.translatesAutoresizingMaskIntoConstraints = false
        onboardingPageControl.translatesAutoresizingMaskIntoConstraints = false
        onboardingPageControl.currentPageIndicatorTintColor = .white
        onboardingPageControl.pageIndicatorTintColor = .systemGray2
        onboardingPageControl.numberOfPages = onboardingPages.count
        onboardingPageControl.currentPage = 0
    }
    
    @objc func onboardingPageControlTapped(_ sender: UIPageControl) {
        setViewControllers([onboardingPages[sender.currentPage]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Constraints

    private func setupConstraints() {
        view.addSubview(onboardingPageControl)
        
        NSLayoutConstraint.activate([
            onboardingPageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            onboardingPageControl.heightAnchor.constraint(equalToConstant: 20),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

}

// MARK: - Delegate

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = onboardingPages.firstIndex(of: viewControllers[0]) else { return }
        
        if (completed || finished) {
            isAnimating = false
        }
        onboardingPageControl.currentPage = currentIndex
    }
}

// MARK: - DataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        isAnimating = true
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingPages.firstIndex(of: viewController) else { return nil }
        
        if isAnimating { return nil }
        
        if currentIndex == 0 {
            return onboardingPages.last
        } else {
            return onboardingPages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingPages.firstIndex(of: viewController) else { return nil }
        
        if isAnimating { return nil }
        
        if currentIndex < onboardingPages.count - 1 {
            return onboardingPages[currentIndex + 1]
        } else {
            return onboardingPages.first
        }
    }
}

// MARK: - Constants

extension OnboardingPageViewController {
    
    enum Constants {
        static let viewBackgroundColor = UIColor(red: 1, green: 0.557, blue: 0.145, alpha: 1)
        static let easyImage = UIImage(named: "easy")
        static let easyText = "Extremely simple to use"
        static let trackerImage = UIImage(named: "tracker")
        static let trackerText = "Track your time and distance"
        static let cyclingImage = UIImage(named: "cycling")
        static let cyclingText = "See your progress and challenge yourself!"
    }
}
