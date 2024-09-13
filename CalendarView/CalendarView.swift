//
//  CalendarView.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class CalendarView: UIView {
    //PROPERTIES
    var headerviewBackgroundColor: UIColor = .red
    var previousBtnImage: UIImage = UIImage(systemName: "arrowshape.left.circle.fill")!
    var nextBtnImage: UIImage = UIImage(systemName: "arrowshape.right.circle.fill")!
    var headerTitle: String = "MONTH NAME"
    
    //UI Element
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let headerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup header view
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup header view
        setupHeaderView()
    }
    
    func setupHeaderView() {
        let headerView = UIView()
        headerView.backgroundColor = headerviewBackgroundColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        
        //add headerview constraint
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.12)
        ])
        
        //setup previous button
        previousButton.setImage(previousBtnImage, for: .normal)
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        headerView.addSubview(previousButton)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        //setup next button
        nextButton.setImage(nextBtnImage, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        headerView.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        //setup header title
        headerLabel.textAlignment = .center
        headerLabel.text = headerTitle
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
    }
    
    @objc private func previousButtonTapped() {
        print("Previous button tapped...")
    }
    
    @objc private func nextButtonTapped() {
        print("Next button tapped...")
    }
}
