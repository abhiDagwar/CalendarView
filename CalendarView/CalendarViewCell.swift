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
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Event Indicator
    private let healthIndicatorView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .clear
        label.text = "H"
        label.translatesAutoresizingMaskIntoConstraints = false
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
        // Add the squareView to the cell's content view
        super.addSubview(squareView)
        // Add the circleView to the cell's content view
        super.addSubview(circleView)
        // Add the date label on top of the circleView
        super.addSubview(titleLabel)
        //Add the event indicator to the corner of cell's content view
        super.addSubview(eventIndicatorView)
        // Add health indicator
        super.addSubview(healthIndicatorView)
        
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
        
        NSLayoutConstraint.activate([
            healthIndicatorView.widthAnchor.constraint(equalToConstant: 10),
            healthIndicatorView.heightAnchor.constraint(equalToConstant: 10),
            healthIndicatorView.topAnchor.constraint(equalTo: eventIndicatorView.bottomAnchor, constant: 5),
            healthIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setUpViewInit() {
        // Example: Clear the background color of only UILabels within the view hierarchy
        self.clearBackgroundColor(of: circleView)
        isUserInteractionEnabled = true
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
        // work, personal, education, social, family, health, and community
        // leisure, recreation, and celebrations
        if let event = event {
            switch event.eventType {
            case "Work", "Recreation", "Celebrations":
                eventIndicatorView.backgroundColor = .blue
            case "Personal", "Social", "Family", "Community":
                eventIndicatorView.backgroundColor = .brown
            case "Education", "Leisure":
                eventIndicatorView.backgroundColor = .red
            case "Health":
                healthIndicatorView.textColor = .orange
            default:
                eventIndicatorView.backgroundColor = .clear
            }
        } else {
            eventIndicatorView.backgroundColor = .clear
            healthIndicatorView.textColor = .clear
        }
    }
    
    // Function to highlight the cell
    func highlightCell(isCurrentDay: Bool) {
        circleView.backgroundColor = .red  // Highlighted color
        titleLabel.textColor = .white       // Text color when selected
        if isCurrentDay {
            squareView.backgroundColor = .clear  // Current day in gray
        }
    }
        
        // Function to unhighlight the cell
    func unhighlightCell(isCurrentDay: Bool) {
        circleView.backgroundColor = .clear // Default transparent
        titleLabel.textColor = .black        // Default text color
        if isCurrentDay {
            squareView.backgroundColor = .systemGray  // Current day in gray
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

extension UIView {
    func clearBackgroundColor(of view: UIView) {
        if self == view {
            self.backgroundColor = .clear
        }
        for subview in subviews {
            subview.clearBackgroundColor(of: view) // Recursively check all subviews
        }
    }
}
