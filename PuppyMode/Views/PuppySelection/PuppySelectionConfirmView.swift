//
//  PuppySelectionConfirmView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import UIKit

class PuppySelectionConfirmView: UIView {
    
    private lazy var mainTitleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 30)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        $0.font = UIFont(name: "Roboto-Regular", size: 18)
    }
    
    private lazy var cardImageView = UIImageView().then {
        $0.image = .puppyCard
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var puppyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    public lazy var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        $0.backgroundColor = .main
        
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainTitleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(cardImageView)
        cardImageView.addSubview(puppyImageView)
        self.addSubview(startButton)
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        cardImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(87)
        }
        
        puppyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(34)
            make.height.equalTo(60)
        }
        
    }
    
    func configure( puppy: BabyPuppyTypeEnum) {
        switch puppy {
        case .babyBichon:
            mainTitleLabel.text = "비숑 프리제"
            subTitleLabel.text = "Bichon Frisé"
            puppyImageView.image = .babyBichon
        case .babyWelshCorgi:
            mainTitleLabel.text = "웰시코기"
            subTitleLabel.text = "Welsh corgi"
            puppyImageView.image = .babyWelshCorgi
        case .babyPomeranian:
            mainTitleLabel.text = "포메라니안"
            subTitleLabel.text = "Pomeranian"
            puppyImageView.image = .babyPomeranian
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview{
    PuppySelectionConfirmViewController()
}
