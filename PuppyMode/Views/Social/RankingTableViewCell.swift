//
//  RankingTableViewCell.swift
//  PuppyMode
//
//  Created by 이승준 on 1/20/25.
//

import UIKit
import SnapKit
import Then

class RankingTableViewCell: UITableViewCell {
    
    static let identifier = "RankingTableViewCell"
    
    private lazy var rankLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        $0.textAlignment = .center
    }
    
    private lazy var profileImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .rankCellDefaultProfile
        $0.layer.cornerRadius = 21
        $0.clipsToBounds = true
    }
    
    private lazy var infoFrame = UIView()    
    private lazy var userNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 16)
    }
    
    private lazy var characterInfoLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.392, green: 0.392, blue: 0.396, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
    }
    
    private lazy var trophyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.prepareForReuse()
    }
    
    public func configure(index: Int, rankCell: RankCell) {
        rankLabel.text = String(index + 1)
        userNameLabel.text = rankCell.name
        characterInfoLabel.text = "\(rankCell.characterName), Level\(rankCell.characterLevel)"
    }
    
    private func addComponents() {
        self.addSubview(rankLabel)
        self.addSubview(profileImage)
        self.addSubview(infoFrame)
        infoFrame.addSubview(userNameLabel)
        infoFrame.addSubview(characterInfoLabel)
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(66)
            make.centerY.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(42)
        }
        
        infoFrame.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
            make.trailing.equalToSuperview().inset(20)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        characterInfoLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
        
    }
    
    public func addTrophyComponent(rank: Rank) {
        switch rank {
        case .first:
            trophyImageView.image = .firstTrophy
        case .second:
            trophyImageView.image = .secondTrophy
        case .third:
            trophyImageView.image = .thirdTrophy
        }
        
        infoFrame.addSubview(trophyImageView)
        
        trophyImageView.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLabel.snp.centerY)
            make.leading.equalTo(userNameLabel.snp.trailing).offset(6)
            make.height.width.equalTo(19)
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

enum Rank: Int {
    case first = 1
    case second = 2
    case third = 3
}

#Preview{
    SocialViewController()
}
