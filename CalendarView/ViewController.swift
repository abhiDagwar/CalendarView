//
//  ViewController.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

class ViewController: UIViewController {

    //Calendar instance
    var calendarView: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup calendarview
        setupCalendarView()
        setupFooterView()
    }
    
    func setupCalendarView() {
        //Initialize the calendarview
        calendarView = CalendarView()
        //Set background color
        calendarView.backgroundColor = .green
        //Add to the viewcontroller
        view.addSubview(calendarView)
        //Set up autolayout
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58)
        ])
    }
    
    func setupFooterView() {
        // Create a footerview at the bottom of the current view(i.e. viewcontroller). Add a red color to the background and create a view using autolayout which is leading and trailing to the viewcontroller's view and bottom is aligned with viewcontroller's view having a height of 50 points.
        let footerView = UIView()
        footerView.backgroundColor = .red
        view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

