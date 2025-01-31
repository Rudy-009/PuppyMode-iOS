//
//  EndDrinkingViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/31/25.
//

import UIKit

class EndDrinkingViewController: UIViewController {

    private let endDrinkingView = EndDrinkingView()

    override func loadView() {
        self.view = endDrinkingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        endDrinkingView.okayButton.addTarget(self, action: #selector(didTapOkayButton), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func didTapOkayButton() {
        dismiss(animated: true, completion: nil)
    }
}
