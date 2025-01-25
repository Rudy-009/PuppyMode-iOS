//
//  DecorationView.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit
import SnapKit

class DecoView: UIView {
    
    // 버튼이 눌린 동작에 대한 선택
    var onTagSelected: ((String) -> Void)?
    public var itemButtons: [UIButton] = []
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: Puppy Image & Name
    lazy public var puppyImageButton = UIButton().then { button in
        button.setImage(UIImage(named: "HomeCharacterDefaultImage"), for: .normal)
    }
    
    lazy private var puppyNameLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        label.text = "이름"
    }
    
    public lazy var renamebutton = UIButton().then { button in
        button.setImage(UIImage(named: "renameButtonImage"), for: .normal)
    }
    
    
    //MARK: Puppy Item
    lazy private var segmentScrollView = UIScrollView().then { scrollView in
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
    }
    
    
    public lazy var itemButtonsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.bouncesVertically = false
        return scrollView
    }()
    
    public lazy var itemButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    
    lazy public var backgroundView = UIView().then { view in
        view.backgroundColor = .decorationBackground
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addComponents() {
        self.addSubview(puppyImageButton)
        puppyImageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(247)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(36)
        }
        
        self.addSubview(puppyNameLabel)
        puppyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(puppyImageButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    
        self.addSubview(renamebutton)
        renamebutton.snp.makeConstraints { make in
            make.leading.equalTo(puppyNameLabel.snp.trailing).offset(6)
            make.width.height.equalTo(23)
            make.centerY.equalTo(puppyNameLabel)
        }
        
        
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(puppyNameLabel.snp.bottom).offset(30)
        }
        
          
        backgroundView.addSubview(itemButtonsScrollView)
        itemButtonsScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(32)
        }
        
        itemButtonsScrollView.addSubview(itemButtonsStackView)
        itemButtonsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview() 
        }
        
        createButtons()
        
    }
    
    
    private func createButtons() {
        var num = 0
        for tag in itemKey.String.tags {
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setTitle(tag, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.layer.cornerRadius = 15
            button.tintColor = .lightGray
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 21, bottom: 8, right: 21)
            button.tag = num
            num += 1
            itemButtons.append(button)
            itemButtonsStackView.addArrangedSubview(button)
        }
    }
    
    public func forEachButton(_ action: (UIButton) -> Void) {
        itemButtonsStackView.arrangedSubviews.compactMap { $0 as? UIButton }.forEach(action)
    }
    
}
