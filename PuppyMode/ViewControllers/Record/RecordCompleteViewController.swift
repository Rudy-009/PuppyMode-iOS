//
//  RecordCompleteViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/27/25.
//

import UIKit

class RecordCompleteViewController: UIViewController {

    private let completionView = RecordCompleteView()

    override func loadView() {
        self.view = completionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupActions()
    }

    // MARK: - Setup Actions
    private func setupActions() {
        completionView.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func actionButtonTapped() {
        print("먹이주러 가기 버튼이 눌렸습니다.")
        
        navigationController?.popToRootViewController(animated: true)
    }
}
