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
    let onboardingStartButton = UIButton(frame: .zero)
    
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
    

    private func setup() {
        view.backgroundColor = Constants.viewBackgroundColor
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setupPages()
        setupPageControl()
        setupStartButton()
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
        onboardingPageControl.currentPageIndicatorTintColor = .white
        onboardingPageControl.pageIndicatorTintColor = .systemGray2
        onboardingPageControl.numberOfPages = onboardingPages.count
        onboardingPageControl.currentPage = 0
    }
    
    private func setupStartButton() {
        onboardingStartButton.addTarget(self, action: #selector(onboardingStartButtonTapped(_:)), for: .touchUpInside)
        onboardingStartButton.translatesAutoresizingMaskIntoConstraints = false
        onboardingStartButton.isHidden = true
        onboardingStartButton.setTitle("Start!", for: .normal)
        onboardingStartButton.titleLabel?.font = .abelRegular(size: 40)
        onboardingStartButton.backgroundColor = UIColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 0.18)
        onboardingStartButton.layer.cornerRadius = 6
    }
    
    private func showStartButtonIfNeeded() {
        let lastPage = onboardingPageControl.currentPage == onboardingPages.count - 1
        if lastPage { onboardingStartButton.isHidden = false }
        else { onboardingStartButton.isHidden = true }
    }

    // MARK: - Actions
    
    @objc func onboardingPageControlTapped(_ sender: UIPageControl) {
        setViewControllers([onboardingPages[sender.currentPage]], direction: .forward, animated: false, completion: nil)
    }
    
    @objc func onboardingStartButtonTapped(_ sender: UIPageControl) {
        let viewController = RideTabBarViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Constraints

    private func setupConstraints() {
        view.addSubview(onboardingPageControl)
        view.addSubview(onboardingStartButton)
        
        NSLayoutConstraint.activate([
            onboardingPageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            onboardingPageControl.heightAnchor.constraint(equalToConstant: 20),
            onboardingPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            onboardingStartButton.widthAnchor.constraint(equalToConstant: view.bounds.width/3),
            onboardingStartButton.heightAnchor.constraint(equalToConstant: 40),
            onboardingStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingStartButton.bottomAnchor.constraint(equalTo: onboardingPageControl.topAnchor, constant: -40)
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
        showStartButtonIfNeeded()
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
        static let buttonBackgroundColor = UIColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 0.18)
        static let easyImage = UIImage(named: "easy")
        static let easyText = "Extremely simple to use"
        static let trackerImage = UIImage(named: "tracker")
        static let trackerText = "Track your time and distance"
        static let cyclingImage = UIImage(named: "cycling")
        static let cyclingText = "See your progress and challenge yourself!"
    }
}
