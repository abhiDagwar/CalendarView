//
//  CalendarViewCell.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
    //Programatically create a title label computed property for CalenderViewCell to display date
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.text = "1"
        return label
    }()
    
    // Circle background view for the selected date
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // Initially transparent
        view.layer.cornerRadius = 20  // Will be adjusted dynamically
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        // Add the circleView to the cell's content view
        super.addSubview(circleView)
        // Add the date label on top of the circleView
        super.addSubview(titleLabel)
        
        // Set up constraints for the circleView
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 16), // Adjust width dynamically
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor) // Keep it square
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // Configure the cell with a date and whether it's selected
    func configure(date: String) {
        titleLabel.text = date
    }
    
    func isHighlighted(_ highlight: Bool) {
        if highlight {
            circleView.backgroundColor = .red  // Highlighted color
            titleLabel.textColor = .white       // Text color when selected
        } else {
            circleView.backgroundColor = .clear // Default transparent
            titleLabel.textColor = .black        // Default text color
        }
    }
    
    // Optional: For rounded corners when selection changes
    override func layoutSubviews() {
        super.layoutSubviews()
        // Dynamically adjust corner radius based on circleView's size
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
    }
    
}
