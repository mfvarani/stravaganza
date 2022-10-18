//
//  ProgressTableViewCell.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 11/10/2022.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {

    static let identifier = "progressCell"
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 42.0)
        label.clipsToBounds = true
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 32.0)
        label.clipsToBounds = true
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(timeLabel)
        addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            distanceLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
    }
}
