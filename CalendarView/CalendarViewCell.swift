//
//  CalendarViewCell.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
    //Programatically create a title label computed property for CalenderViewCell
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.text = "1"
        return label
    }()
    
    //Initialize cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .green
        setupCell()
    }
    
    fileprivate func setupCell() {
        super.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
