//
//  DrankAlcoholTableViewCell.swift
//  PuppyMode
//
//  Created by 박준석 on 1/29/25.
//

import UIKit

class DrankAlcoholTableViewCell: UITableViewCell {
    // MARK: - Views
    let alcoholImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let alcoholNameLabel = UILabel().then {
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        $0.textColor = UIColor(red: 138 / 255, green: 138 / 255, blue: 142 / 255, alpha: 1.0)
    }
    
    let sliderValueLabel = UILabel().then {
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        $0.textColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
    }
    
    let deleteButton = UIButton(type: .system).then {
        $0.setTitle("-", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
        // Add corner radius to contentView
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    private func setupViews() {
        contentView.addSubview(alcoholImageView)
        contentView.addSubview(alcoholNameLabel)
        contentView.addSubview(sliderValueLabel)
        contentView.addSubview(deleteButton)
        
        alcoholImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(72) // Adjust size as needed
        }
        
        alcoholNameLabel.snp.makeConstraints {
            $0.left.equalTo(alcoholImageView.snp.right).offset(24)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(100) // Adjust width as needed
        }
        
        sliderValueLabel.snp.makeConstraints {
            $0.right.equalTo(deleteButton.snp.left).offset(-50)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(60) // Adjust width as needed
        }
        
        deleteButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50) // Adjust size as needed
        }
    }
}
