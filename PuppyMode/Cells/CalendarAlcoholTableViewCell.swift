//
//  CalendarAlcoholTableViewCell.swift
//  PuppyMode
//
//  Created by 김미주 on 11/02/2025.
//

import UIKit

class CalendarAlcoholTableViewCell: UITableViewCell {
    static let identifier = "CalendarAlcoholTableViewCell"
    
    // MARK: - layout
    private let backView = UIView()
    
    public let alcoholLabel = UILabel().then {
        $0.text = "술 이름"
        $0.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.96)
    }
    
    public let intakeLabel = UILabel().then {
        $0.text = "섭취량"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 13.96)
    }

    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - function
    private func setView() {
        [
            backView, alcoholLabel, intakeLabel
        ].forEach {
            addSubview($0)
        }
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(53)
        }
        
        alcoholLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(27)
        }
        
        intakeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-18)
        }
    }
}
