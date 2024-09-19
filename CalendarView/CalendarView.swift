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
    var collectioViewHeight = 0.0
    
    //UI Element
    private let headerView =  UIView()
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let headerLabel = UILabel()
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup header view
        setupHeaderView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup header view
        setupHeaderView()
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure collectionView has a valid frame size before setting the cell size
        if collectionView.frame.size.width > 0 {
            collectioViewHeight = collectionView.frame.height
            setupCellView()  // Adjust the cell size when the view's layout changes (e.g., on rotation)
        }
        
    }
    
    //setup headerview for calendar
    private func setupHeaderView() {
        //setup a headerview
        headerView.backgroundColor = headerviewBackgroundColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        
        //add headerview constraint
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.09)
        ])
        
        //setup previous button
        previousButton.setImage(previousBtnImage, for: .normal)
        previousButton.tintColor = .black
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        headerView.addSubview(previousButton)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        //setup next button
        nextButton.setImage(nextBtnImage, for: .normal)
        nextButton.tintColor = .black
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
    
    //setup collectionview for calendar dates and weeks name.
    private func setupCollectionView() {
        //setup a flow layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2  // Space between items in the same row
        layout.minimumLineSpacing = 2      // Space between rows of items
        
        //setup a collectioview using the above layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cyan
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Register cell for the above collectionview
        collectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
        //Register a headerview to show days of week
        collectionView.register(CalendarViewDaysHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarViewDaysHeader")
        //add collectionview to view
        addSubview(collectionView)
        
        //setup autolayout for collectionview
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCellView() {
        //Get the collectionview layout
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        // Check that the collectionView's frame size is valid
        if collectionView.frame.size.width <= 0 {
            return // Exit if the collectionView has no valid size yet
        }
        
        let numberOfCellsInRow: CGFloat = 7
        let totalSpacing = layout.minimumInteritemSpacing * (numberOfCellsInRow - 1) // Total space between cells
        
        let availableWidth = collectionView.frame.width - totalSpacing
        
        // Ensure the cell width is valid (greater than zero)
        let cellWidth = max((availableWidth / numberOfCellsInRow), 0)
        
        let numberOfRowsinColumn: CGFloat = 6 + 4 // Number of rows + extra height adjustment as per your requirement
        let totalSpacingForRows = layout.minimumLineSpacing * (numberOfRowsinColumn - 1)
        let availableHeight = collectionView.frame.height - totalSpacingForRows
        let cellHeight = max((availableHeight / numberOfRowsinColumn), 0)
        
        // Assign size for cells
        // Asign width and height both the same value if you want to make it square e.g. (width: cellWidth, height: cellWidth)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        layout.invalidateLayout() // Invalidate the layout to apply changes
        
        // Debug print for checking the values
        print("Collection View Width: \(collectionView.frame.width)")
        print("Available Width: \(availableWidth)")
        print("Cell Width: \(cellWidth)")
        print("Collection View Height: \(collectionView.frame.height)")
    }
    
    @objc private func previousButtonTapped() {
        print("Previous button tapped...")
    }
    
    @objc private func nextButtonTapped() {
        print("Next button tapped...")
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CalendarViewDaysHeader", for: indexPath) as! CalendarViewDaysHeader
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40) //Adjust height as needed
    }
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarViewCell", for: indexPath)
        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected date: ---\(indexPath.item + 1)")
    }
}
