//
//  AddressSearchModalViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit

class AddressSearchModalViewController: UIViewController {
    
    // UI Elements
    private let navigationBar = UIView().then {
        $0.backgroundColor = UIColor(hex: "#FFFFFF") // 네비게이션 바 배경색
    }

    private let titleLabel = UILabel().then {
        $0.text = "장소 선택"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }

    private let closeButton = UIButton(type: .system).then {
        $0.setTitle("X", for: .normal)
        $0.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "도로명, 건물명, 지번 입력"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        
        // 아래쪽 테두리 추가
        $0.borderStyle = .none // 기본 테두리 제거
        $0.layer.addSublayer({
            let border = CALayer()
            border.backgroundColor = UIColor(hex: "#73C8B1").cgColor // 아래쪽 테두리 색상
            border.frame = CGRect(x: 0, y: 39, width: UIScreen.main.bounds.width - 40, height: 1) // 위치와 크기 설정
            return border
        }())
        
        // 탭 제스처 추가
        let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconImageView.tintColor = UIColor(hex: "#73C8B1") // 아이콘 색상 설정
        iconImageView.contentMode = .scaleAspectFit      // 아이콘 크기 조정 모드 설정
        iconImageView.isUserInteractionEnabled = true
        
        $0.rightView = iconImageView
        $0.rightViewMode = .always // 항상 아이콘 표시
    }
    
    private let resultsTableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "AddressCell")
    }
    
    private var searchResults: [String] = [] // 검색 결과를 저장할 배열
    
    // 로컬 주소 데이터 (미리 정의된 데이터)
    private let addressData: [String] = [
        "서울특별시 강남구 테헤란로 427",
        "서울특별시 종로구 세종대로 99",
        "서울특별시 서초구 서초대로 396",
        "경기도 성남시 분당구 판교역로 235",
        "부산광역시 해운대구 센텀중앙로 55",
        "대전광역시 유성구 대덕대로 480",
        "광주광역시 북구 첨단과기로 208",
        "인천광역시 연수구 송도과학로 85"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        
        // Add gesture recognizer to the search icon
        if let iconImageView = searchTextField.rightView as? UIImageView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchIcon))
            iconImageView.addGestureRecognizer(tapGesture)
        }
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil) // 모달 닫기
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        
        view.addSubview(navigationBar)
        navigationBar.addSubview(titleLabel)
        navigationBar.addSubview(closeButton)
        
        view.addSubview(searchTextField)
        view.addSubview(resultsTableView)
    }
    
    private func setupLayout() {
        
        // Layout for navigation bar
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150) // 네비게이션 바 높이 설정
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 중앙 정렬
            make.centerY.equalToSuperview() // 수직 중앙 정렬
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(20) // 오른쪽 여백 설정
            make.width.height.equalTo(30) // 버튼 크기 설정
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(0) // 네비게이션 바 아래 배치
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Button Action
    
    @objc private func didTapSearchIcon() {
        guard let query = searchTextField.text, !query.isEmpty else {
            print("도로명, 건물명, 지번 입력") // 검색어가 비어있을 경우 처리
            return
        }
        
        // 로컬 데이터에서 검색어 필터링
        searchResults = addressData.filter { $0.contains(query) }
        
        // 검색 결과가 없을 경우 처리
        if searchResults.isEmpty {
            print("검색 결과가 없습니다.")
            searchResults.append("검색 결과가 없습니다.")
        }
        
        resultsTableView.reloadData() // 테이블 뷰 갱신
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension AddressSearchModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        
        cell.textLabel?.text = searchResults[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAddress = searchResults[indexPath.row]
        
        print("선택된 주소:", selectedAddress)
        
        // 전달된 주소를 처리하거나 부모 뷰 컨트롤러로 전달할 수 있음
        
        dismiss(animated: true, completion: nil) // 모달 닫기
    }
}
