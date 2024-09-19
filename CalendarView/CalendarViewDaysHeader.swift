//
//  CalendarViewDaysHeader.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class CalendarViewDaysHeader: UICollectionReusableView {
    private var daysOfWeekFull = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private var daysOfWeekShort = ["S", "M", "T", "W", "T", "F", "S"]
    
    private var labels = [UILabel]() // Store the labels for each day
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSectionHeaderView()
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSectionHeaderView()
        backgroundColor = .yellow
    }
    
    // Detect layout changes
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustDayLabelText()
    }
    
    // Set up the header view with a horizontal stack view for days
    private func setupSectionHeaderView() {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        
        for i in 0..<daysOfWeekFull.count {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.text = daysOfWeekFull[i]
            label.textColor = .black
            labels.append(label)
            stackview.addArrangedSubview(label)
        }
        
        addSubview(stackview)
        
        // Setup constraints for the stack view
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Adjust the text in the labels based on the available width
    private func adjustDayLabelText() {
        // Calculate the available width for each label
        let labelWidth = frame.width / CGFloat(daysOfWeekFull.count)
        
        // Determine if we need to switch to short day names
        let useShortNames = labelWidth < 30 // Set a threshold (can be adjusted)
        
        for (index, label) in labels.enumerated() {
            label.text = useShortNames ? daysOfWeekShort[index] : daysOfWeekFull[index]
        }
    }
}
