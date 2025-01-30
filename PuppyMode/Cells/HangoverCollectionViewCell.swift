//
//  HangoverCollectionViewCell.swift
//  PuppyMode
//
//  Created by 김미주 on 17/01/2025.
//

import UIKit

class HangoverCollectionViewCell: UICollectionViewCell {
    static let identifier = "HangoverCollectionViewCell"
    
    // MARK: - layout
    // 이미지
    public let hangoverImage = UIImageView().then {
        $0.backgroundColor = .main
    }
    
    // 텍스트
    public let hangoverLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 16)
    }
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        [
            hangoverImage,
            hangoverLabel
        ].forEach {
            addSubview($0)
        }
        
        hangoverImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        hangoverLabel.snp.makeConstraints {
            $0.top.equalTo(hangoverImage.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
