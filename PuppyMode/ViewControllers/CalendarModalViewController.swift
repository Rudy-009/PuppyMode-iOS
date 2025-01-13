//
//  CalendarModalViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 10/01/2025.
//

import UIKit

class CalendarModalViewController: UIViewController {
    private let calendarModalView = CalendarModalView()
    private weak var calendarView: CalendarView?
    
    init(calendarView: CalendarView) {
        self.calendarView = calendarView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarModalView
        
        setDelegate()
        setAction()
    }
    
    // MARK: - function
    private func setDelegate() {
        calendarModalView.monthCollectionView.dataSource = self
        calendarModalView.monthCollectionView.delegate = self
    }
    
    // MARK: - action
    private func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        calendarModalView.addGestureRecognizer(tapGesture)
        calendarModalView.isUserInteractionEnabled = true
    }
    
    @objc
    private func backgroundTapped() {
        self.calendarView?.blurBackgroundView.isHidden = true
        dismiss(animated: true)
    }

}

// MARK: - extension
extension CalendarModalViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MonthModel.dummy().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.identifier, for: indexPath) as? MonthCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = MonthModel.dummy()
        cell.monthLabel.text = list[indexPath.row].month
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth / 3
        let cellHeight: CGFloat = 65
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
