//
//  DrinkingViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/24/25.
//

import UIKit

class DrinkingViewController: UIViewController {

    private let drinkingView = DrinkingView()

    override func loadView() {
        self.view = drinkingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        drinkingView.promiseButton.addTarget(self, action: #selector(didTapPromiseButton), for: .touchUpInside)
        drinkingView.endButton.addTarget(self, action: #selector(didTapEndButton), for: .touchUpInside)
    }

    private func setupNavigationBar() {
        self.title = "술 마시는 중"
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal) // Use SF Symbols or your own image asset.
        backButton.tintColor = UIColor.black
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
    }

    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapPromiseButton() {
       print("Promise button tapped!")
        // Create a container view for the picker and toolbar
        let pickerContainerView = UIView()
        pickerContainerView.backgroundColor = UIColor.white
        pickerContainerView.layer.cornerRadius = 10
        pickerContainerView.clipsToBounds = true
        
        
        // Create UIDatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        pickerContainerView.addSubview(datePicker)
        
        // Create Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Customizing the toolbar appearance
        toolbar.barTintColor = UIColor(hex: "#FFFFFF") // Toolbar 배경색
        toolbar.tintColor = UIColor(hex: "#3C3C3C")   // 버튼 텍스트 색상
        
        // Toolbar buttons
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancelPicker))
        cancelButton.setTitleTextAttributes([.font: UIFont(name: "NotoSansKR-Medium", size: 14)!], for: .normal)
        
        let confirmButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(didTapConfirmPicker))
        confirmButton.setTitleTextAttributes([.font: UIFont(name: "NotoSansKR-Medium", size: 14)!], for: .normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, flexibleSpace, confirmButton], animated: false)
        
        pickerContainerView.addSubview(toolbar)
        
        // Add to the main view
        view.addSubview(pickerContainerView)
        
        // Layout for pickerContainerView
        pickerContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300) // Adjust height as needed
            make.bottom.equalTo(self.view.snp.bottom).offset(300) // Start below the screen
        }
        
        // Layout for datePicker
        datePicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(216) // Standard height for UIDatePicker
        }
        
        // Layout for toolbar
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(datePicker.snp.top).offset(-10)
            make.height.equalTo(44) // Standard height for toolbar
        }
        
        // Animate Picker Container View to slide up from the bottom
        UIView.animate(withDuration: 0.3) {
            pickerContainerView.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom) // Move to the bottom of the screen (visible)
            }
            self.view.layoutIfNeeded() // Apply layout changes immediately during animation
        }
    }
    
    @objc private func didTapCancelPicker() {
        guard let pickerContainerView = view.subviews.last else { return }

            UIView.animate(withDuration: 0.3, animations: {
                pickerContainerView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.snp.bottom).offset(300) // Slide down below the screen
                }
                self.view.layoutIfNeeded() // Apply layout changes immediately during animation
            }) { _ in
                pickerContainerView.removeFromSuperview() // Remove from superview after animation completes
           }
    }

    @objc private func didTapConfirmPicker() {
        guard let pickerContainerView = view.subviews.last as? UIView,
              let datePicker = pickerContainerView.subviews.compactMap({ $0 as? UIDatePicker }).first else { return }
        
        // 선택된 시간 가져오기
        let selectedTime = datePicker.date
        
        // Format the selected time and set it to the button title
        let formatter = DateFormatter()
        formatter.timeStyle = .short // Short style (e.g., "오후 11:00")
        
        drinkingView.promiseButton.setTitle(formatter.string(from: selectedTime), for: .normal)
        
        print("선택된 시간:", formatter.string(from: selectedTime))
        
        // Picker를 닫습니다.
        pickerContainerView.removeFromSuperview()
    }

    @objc private func didTapEndButton() {
       print("End button tapped!")
       // Add functionality to end drinking session.
       dismiss(animated: true, completion: nil) // Example action.
    }
}
