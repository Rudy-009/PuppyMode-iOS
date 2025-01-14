//
//  PolicyPopoverViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/13/25.
//

import UIKit

class SettingPopoverViewController: UIViewController {

    let popover = PolicyOrTermPopoverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = popover
        popover.confirmButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
    }
    
    @objc
    func popView() {
        dismiss(animated: true, completion: nil)
    }
    
    public func configurePopoverView(title: String, content: String) {
        popover.configure(title: title, content: content)
    }

}
