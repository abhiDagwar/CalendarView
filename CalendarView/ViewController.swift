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
        print(calendarView.collectionView.frame.size.height)
    }
    
    func setupCalendarView() {
        //Initialize the calendarview
        calendarView = CalendarView()
        //backgroundcolor
        calendarView.backgroundColor = .green
        //Add to the viewcontroller
        view.addSubview(calendarView)
        //setup autolayout
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

