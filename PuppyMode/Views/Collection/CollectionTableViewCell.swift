//
//  CollectionTableViewCell.swift
//  PuppyMode
//
//  Created by 김민지 on 1/29/25.
//

import UIKit
import Then

class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    
    public lazy var collectionImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(hex: "#D9D9D9")
    }
    
    private lazy var stackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = 1
    }

    public lazy var titleLabel = UILabel().then { label in
        label.textColor = .black
        label.textAlignment = .left
        label.text = "별이 하나"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
    }
    
    public lazy var subtitleLabel = UILabel().then { label in
        label.textColor = UIColor(hex: "#8A8A8E")
        label.textAlignment = .left
        label.text = "머리가 아파요 3회 달성시"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    }
    
    public lazy var progressBar = UIProgressView().then{ pro in
        pro.setProgress(2/3, animated: false)
        pro.tintColor = .main
        pro.largeContentImage = UIImage(named: "ProgressBarBackground")
        pro.clipsToBounds = true
        pro.layer.cornerRadius = 5
    }
    
    public lazy var progressLabel = UILabel().then { label in
        label.textColor = UIColor(hex: "#8A8A8E")
        label.textAlignment = .center
        label.text = "2/3"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    }
    
    private lazy var separatorView = UIView().then { view in
        view.backgroundColor = UIColor(hex: "#8E8E8E")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addComponents()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionImageView.layer.cornerRadius = collectionImageView.frame.width / 2
    }

        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(collectionImageView)
        self.addSubview(stackView)

        collectionImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview().offset(0.5)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(collectionImageView.snp.trailing).offset(10)
            make.width.equalTo(251)
        }
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)

        self.addSubview(progressLabel)
        self.addSubview(progressBar)
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalTo(stackView)
            make.width.equalTo(251)
            make.height.equalTo(10)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.leading.equalTo(progressBar.snp.trailing).offset(3)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(48)
        }
        
        self.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(progressBar.snp.bottom).offset(30)
        }
    }
    
    func configureSeparator(isLastCell: Bool) {
        separatorView.isHidden = isLastCell
    }
}
