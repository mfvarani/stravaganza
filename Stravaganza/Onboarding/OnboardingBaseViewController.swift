//
//  OnboardingBaseViewController.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 07/10/2022.
//

import UIKit

class OnboardingBaseViewController: UIViewController {
    
    // MARK: - Properties

    var viewModel: OnboardingViewModel
    
    // MARK: - Views

    var onboardingLabel = UILabel()
    var onboardingImageView = UIImageView()
    
    // MARK: - Lifecycle

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Constants.viewBackgroundColor
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setupLabel()
        setupImageView()
    }
    
    private func setupLabel() {
        onboardingLabel.text = viewModel.text
        onboardingLabel.textColor = Constants.labelTextColor
        onboardingLabel.font = Constants.labelFont
        onboardingLabel.textAlignment = Constants.labelAlignment
        onboardingLabel.numberOfLines = 0
        onboardingLabel.translatesAutoresizingMaskIntoConstraints = false
        onboardingLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupImageView() {
        onboardingImageView.image = viewModel.image
        onboardingImageView.contentMode = .scaleAspectFit
        onboardingImageView.backgroundColor = Constants.imageViewBackgroundColor
        onboardingImageView.clipsToBounds = true
        onboardingImageView.sizeToFit()
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        onboardingImageView.layer.cornerRadius = 6
    }
    
    // MARK: - Constraints

    private func setupConstraints() {
        view.addSubview(onboardingImageView)
        view.addSubview(onboardingLabel)

        NSLayoutConstraint.activate([
            onboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * -0.15),
            onboardingImageView.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            onboardingImageView.heightAnchor.constraint(equalToConstant: view.frame.width/3),
            
            onboardingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 7),
            onboardingLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
    }
}

// MARK: - Constants

extension OnboardingBaseViewController {
    
    enum Constants {
        static let viewBackgroundColor = UIColor(red: 1, green: 0.557, blue: 0.145, alpha: 1)
        static let imageViewBackgroundColor: UIColor = .clear
        static let labelTextColor: UIColor = .white
        static let labelSize: CGFloat = 32.0
        static let labelFont: UIFont = .abelRegular(size: labelSize)
        static let labelAlignment: NSTextAlignment = .center
    }
}
