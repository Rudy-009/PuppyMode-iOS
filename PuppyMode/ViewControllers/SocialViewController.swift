//
//  SocialViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class SocialViewController: UIViewController {
    
    let socialView = SocialView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = socialView
        setupAction()
    }
    
    private func setupAction() {
        socialView.segmentView.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }
    
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            socialView.label01.isHidden = false
            socialView.label02.isHidden = true
        } else {
            socialView.label01.isHidden = true
            socialView.label02.isHidden = false
        }
    }

}

#Preview{
    SocialViewController()
}

