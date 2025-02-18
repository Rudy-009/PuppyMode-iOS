//
//  PolicyPopoverViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/13/25.
//

import UIKit

class PolicyOrTermPopoverViewController: UIViewController {
    
    private lazy var popover = PolicyOrTermPopoverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = popover
        popover.confirmButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGrayAreaTap(_:)))
        // 팝오버의 배경뷰에 제스처 추가
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func popView() {
        dismiss(animated: true, completion: nil)
    }
    
    public func configurePopoverView(title: String, content: String) {
        popover.configure(title: title, content: content)
    }
    
    @objc
    func handleGrayAreaTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        // popover.frameView 영역을 터치했는지 확인
        if !popover.frameView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
