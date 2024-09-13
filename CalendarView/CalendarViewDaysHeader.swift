//
//  CalendarViewDaysHeader.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class CalendarViewDaysHeader: UICollectionReusableView {
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
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
    
    private func setupSectionHeaderView() {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        
        for day in daysOfWeek {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.text = day
            label.textColor = .black
            stackview.addArrangedSubview(label)
        }
        
        addSubview(stackview)
        
        //setup constraint
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
