//
//  PolicyPopoverViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/13/25.
//

import UIKit

class PolicyPopoverViewController: UIViewController {

    let popover = PolicyPopoverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = popover
        popover.configure(title: "이용 약관", content: K.String.policy)
        popover.confirmButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
    }
    
    @objc
    func popView() {
        dismiss(animated: true, completion: nil)
    }

}
