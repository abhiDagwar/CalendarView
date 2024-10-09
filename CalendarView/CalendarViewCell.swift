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
    
    // Square background view for the today's date
    private let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // Initially transparent
        view.layer.cornerRadius = 4  // Will be adjusted dynamically
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    //Event Indicator
    private let eventIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
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
        // Add the squareView to the cell's content view
        super.addSubview(squareView)
        // Add the circleView to the cell's content view
        super.addSubview(circleView)
        // Add the date label on top of the circleView
        super.addSubview(titleLabel)
        //Add the event indicator to the corner of cell's content view
        super.addSubview(eventIndicatorView)
        
        // Set up constraints for the squareView
        NSLayoutConstraint.activate([
            squareView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            squareView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 20), // Adjust width dynamically
            squareView.heightAnchor.constraint(equalTo: circleView.widthAnchor) // Keep it square
        ])
        
        // Set up constraints for the circleView
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 16), // Adjust width dynamically
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor) // Keep it square
        ])
        
        // Setup constraints for the date label(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Set up constraints for the event indicator view
        NSLayoutConstraint.activate([
            eventIndicatorView.widthAnchor.constraint(equalToConstant: 10),
            eventIndicatorView.heightAnchor.constraint(equalToConstant: 10),
            eventIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            eventIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    // Configure the cell with a date and whether it's selected
    func configure(date: String, isCurrentDay: Bool, event: CalendarEvent? = nil) {
        
        if date.isEmpty {
            isUserInteractionEnabled = false
        }
        
        titleLabel.text = date
        
        if isCurrentDay {
            squareView.backgroundColor = .systemGray  // Current day in gray
            titleLabel.textColor = .white
        } else {
            squareView.backgroundColor = .clear
            titleLabel.textColor = .black
        }
        
        // Set event color
        if let event = event {
            switch event.eventType {
            case "work":
                eventIndicatorView.backgroundColor = .blue
            case "personal":
                eventIndicatorView.backgroundColor = .brown
            case "fitness":
                eventIndicatorView.backgroundColor = .red
            default:
                eventIndicatorView.backgroundColor = .clear
            }
        } else {
            eventIndicatorView.backgroundColor = .clear
        }
    }
    
    func isHighlighted(_ highlight: Bool, isCurrentDay: Bool) {
        if highlight {
            circleView.backgroundColor = .red  // Highlighted color
            titleLabel.textColor = .white       // Text color when selected
            if isCurrentDay {
                squareView.backgroundColor = .clear  // Current day in gray
            }
        } else {
            circleView.backgroundColor = .clear // Default transparent
            titleLabel.textColor = .black        // Default text color
            if isCurrentDay {
                squareView.backgroundColor = .systemGray  // Current day in gray
            }
        }
    }
    
    // Optional: For rounded corners when selection changes
    override func layoutSubviews() {
        super.layoutSubviews()
        // Dynamically adjust corner radius based on circleView's size
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
    }
    
}
