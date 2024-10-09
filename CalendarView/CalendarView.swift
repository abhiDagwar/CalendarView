//
//  CalendarView.swift
//  CalendarView
//
//  Created by Abhishek Dagwar on 13/09/24.
//

import UIKit

protocol CalendarViewDelegate: AnyObject {
    func calendarDidSelectDate(_ date: Date)
}

enum CalendarViewType {
    case monthly
    case weekly
}

class CalendarView: UIView {
    //MARK: - PROPERTIES
    private let calendarViewHelper = CalendarViewHelper()
    private var selectedDate = Date()
    private var daysInView = [String]()
    private var highlightedIndexPath: IndexPath?
    
    weak var delegate: CalendarViewDelegate?
    
    private var headerTitle: String = "MONTH NAME"
    private var viewType: CalendarViewType = .monthly
    
    //UI Element
    var headerviewBackgroundColor: UIColor = .red
    var previousBtnImage: UIImage = UIImage(systemName: "arrowshape.left.circle.fill")!
    var nextBtnImage: UIImage = UIImage(systemName: "arrowshape.right.circle.fill")!
    private let headerView =  UIView()
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let headerLabel = UILabel()
    private var collectionView: UICollectionView!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup header view
        setupHeaderView()
        setupCollectionView()
        setView(for: viewType)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup header view
        setupHeaderView()
        setupCollectionView()
        setView(for: viewType)
    }
    
    //MARK: - Re-Render View
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure collectionView has a valid frame size before setting the cell size
        if collectionView.frame.size.width > 0 {
            setupCellView()  // Adjust the cell size when the view's layout changes (e.g., on rotation)
        }
        
    }
    
    //MARK: - Setup headerview for calendar
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
    
    //MARK: - Setup collectionview for calendar dates and weeks name.
    private func setupCollectionView() {
        //setup a flow layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1  // Space between items in the same row
        layout.minimumLineSpacing = 1      // Space between rows of items
        
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
    
    //MARK: - Setup Month Cell View
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
        
        let numberOfRowsInColumn: CGFloat = 6 + 0.65 // Number of rows + extra height adjustment as per your requirement
        let totalSpacingForRows = layout.minimumLineSpacing * (numberOfRowsInColumn - 1)
        let availableHeight = collectionView.frame.height - totalSpacingForRows
        let cellHeight = max((availableHeight / numberOfRowsInColumn), 0)
        
        // Assign size for cells
        // Asign width and height both the same value if you want to make it square e.g. (width: cellWidth, height: cellWidth)
        ///If height is equal to cellHeight then as per logic the assigned collection view height is approximately equal to view height. In this case the scroll is not applicable. To make calendar scroll add total cellHeight of rows more than view height. Try cellWidth instead of cellHeight to check.
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        layout.invalidateLayout() // Invalidate the layout to apply changes
        
        // Debug print for checking the values
        print("Collection View Width: \(collectionView.frame.width)")
        print("Available Width: \(availableWidth)")
        print("Available Height: \(frame.height)")
        print("Cell Width: \(cellWidth)")
        print("Collection View Height: \(collectionView.frame.height)")
    }
    // MARK: - Set View (Monthly or Weekly)
    func setView(for type: CalendarViewType) {
        viewType = type
        setDatesForCurrentView()
    }
    
    private func setDatesForCurrentView() {
        daysInView.removeAll()
        
        //Check view type. If monthly add monthView else weekView
        if viewType == .monthly {
            setMonthView() //Currently working on monthly view only
        } else {
            //TODO: -
            //setWeekView()
        }
        
        collectionView.reloadData()
    }
    
    // MARK: - Set Month View
    private func setMonthView() {
        let daysInSelectedMonth = calendarViewHelper.daysInMonth(for: selectedDate)
        let firstDayOfMonth = calendarViewHelper.firstDayOfMonth(for: selectedDate)
        let startingSpaces = calendarViewHelper.weekDay(date: firstDayOfMonth)
        
        ///Check starting spaces and total days in current month. If it is less than equal to 35 then add 5 rows else add 6 rows
        let daysCount = startingSpaces + daysInSelectedMonth <= 35 ? 35 : 42
        var count = 1
        while count <= daysCount {  // 42 cells for a 6x7 grid
            if count <= startingSpaces || count - startingSpaces > daysInSelectedMonth {
                daysInView.append("")
            } else {
                daysInView.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        updateHeaderLabel()
    }
    
    // MARK: - Update Header Label
    private func updateHeaderLabel() {
        let monthString = calendarViewHelper.monthString(date: selectedDate)
        let yearString = calendarViewHelper.yearString(date: selectedDate)
        headerTitle = "\(monthString) \(yearString)"
        headerLabel.text = headerTitle
    }
    
    //MARK: - Actions/Selectors
    ///Header view button to select previous month
    @objc private func previousButtonTapped() {
        print("Previous button tapped...")
    }
    ///Header view button to select next month
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
        return daysInView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarViewCell", for: indexPath) as! CalendarViewCell
        
        // Example: Configure the cell with the date and selection state
        let date = daysInView[indexPath.item]
        let isCurrentDay = checkIfCurrentDay(for: indexPath)
        cell.configure(date: date, isCurrentDay: isCurrentDay)

        return cell
    }
    
    // MARK: - Check Current Day
    private func checkIfCurrentDay(for indexPath: IndexPath) -> Bool {
        let currentDate = Date()
        let currentMonthStr = calendarViewHelper.monthString(date: currentDate)
        let selectedMonthStr = calendarViewHelper.monthString(date: selectedDate)
        let currentDayStr = calendarViewHelper.dayString(date: currentDate)
        
        let dayStr = daysInView[indexPath.item]
        return (selectedMonthStr == currentMonthStr && currentDayStr == dayStr)
    }

}

extension CalendarView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayStr = daysInView[indexPath.item]
        guard !dayStr.isEmpty, let _ = Int(dayStr) else { return }
        
        // Highlight the cell
        highlightCellFor(collectionView, indexPath)
        
        // Notify the delegate
        if let selectedDate = calendarViewHelper.createDate(from: dayStr, monthNameString: calendarViewHelper.monthString(date: selectedDate), yearString: calendarViewHelper.yearString(date: selectedDate)) {
            delegate?.calendarDidSelectDate(selectedDate)
        }
    }
    
    private func highlightCellFor(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        // Get the cell from collection and indexpath
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarViewCell
        // 1. Check if the selected indexpath is same or not
        if let hightlightedIndexPath = self.highlightedIndexPath, hightlightedIndexPath == indexPath {
            // 2. If the indexpath is same then deselect the current highlighted cell and clear the highlightedIndexPath
            let isCurrentDay = checkIfCurrentDay(for: indexPath)
            cell.isHighlighted(false, isCurrentDay: isCurrentDay)
            collectionView.deselectItem(at: indexPath, animated: true)
            highlightedIndexPath = nil
        } else {
            // 3. If the indexpath is new then check if any previous highlighted cell is there or not
            if let previousHighlightedIndexPath = highlightedIndexPath {
                // 4. Get the previous highlighted cell from the previousHighlightedIndexPath
                let previousCell = collectionView.cellForItem(at: previousHighlightedIndexPath) as! CalendarViewCell
                let isCurrentDay = checkIfCurrentDay(for: previousHighlightedIndexPath)
                // 5. Deselect the highlighted cell
                previousCell.isHighlighted(false, isCurrentDay: isCurrentDay)
                collectionView.deselectItem(at: previousHighlightedIndexPath, animated: true)
            }
            let isCurrentDay = checkIfCurrentDay(for: indexPath)
            // 6. Then select the new highlighted cell
            cell.isHighlighted(true, isCurrentDay: isCurrentDay)
            // 7. Update the highlightedindexpath
            highlightedIndexPath = indexPath
        }
    }
}
