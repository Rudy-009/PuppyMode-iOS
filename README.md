# 🐶 강아지모드 iOS 🍎

## UMC 7th 데모데이 최우수상 수상작 🏆

## 강아지 모드 담당 파트 시연 영상
| Kakao Login | Kakao Signup | Kakao Friends |Apple Login |
| --- | --- | --- | --- |
|<center> <img src = "https://github.com/user-attachments/assets/1463352c-f031-4046-951c-0d727d318d24" width = "80%" height = "80%"/>  </center>| <center> <img src = "https://github.com/user-attachments/assets/6ac8ebf7-02c0-4da7-b64a-523c029e4300" width = "80%" height = "80%"/> </center> | <center> <img src = "https://github.com/user-attachments/assets/b6cfc560-6c7c-4d26-aa89-bd7646d8f1ab" width = "90%" height = "90%"/> </center> | <center> <img src = "https://github.com/user-attachments/assets/380a0f87-a4fc-4b30-9d59-847ae23351a5" width = "110%" height = "110%"/> </center> |

| Animation | FCM, Setting | Debounce |
| --- | --- | --- |
|<center> <img src = "https://github.com/user-attachments/assets/6bbdf8d4-8b04-44c5-b893-be53ec256c85" width = "90%" height = "90%"/>  </center>| <center> <img src = "https://github.com/user-attachments/assets/f17b95ec-63be-4835-abaa-1f4dadda712d" width = "110%" height = "110%"/> </center> | <center> <img src = "https://github.com/user-attachments/assets/07b861d6-7178-438d-be6a-d99de0d3ab40" width = "90%" height = "90%"/> </center> | 

# 이번 프로젝트를 통해 얻게된 것

## 1. 페이지네이션 개선
이전 프로젝트에서 겪은 페이지네이션의 문제 <br>
### 문제1. 중복 호출
호출을 제어하지 못하여, 1,2,3,4,5,6,7,8,9,10,... 이 되어야 하는데 1,2,3,1,2,3,1,2,3,1,2,3,4,5,6,4,5,6,4,5,6,4,5,6 인 결과가 나타남. 같은 인덱스 호출을 하지 못하게 제어해야함. <br>
### 문제2. 한 이벤트에 대해 너무 많은 함수 호출
ScrollView의 바닥에 다다랐을 때, 7,8회 정도의 API를 호출함. <br>

### 해결1. 인덱스 호출 제어

RankingService.swift 파일 참고
`isFetchingData` 타입 변수를 통해, API를 호출할지 말지를 결정. 이로써 중복 호출을 방지할 수 있다.

```swift
class RankingServie {
    static var isFetchingData: Bool = false
    static var page: Int = 0
    static var size: Int = 10

    func fetchData() {
        if isFetchingData { return } // fetch가 진행중이면, 함수를 종료
        isFetchingData = true // fetch가 진행중임을 표시
        fetch(page: page, size: size) {
            // fetch 가 종료 된 이후
            page += size
            isFetchingData = false
        }
    }
}
```

### 해결2. Debounce 를 이용한 이벤트당 호출 횟수 제한, UX 개선

|디바운스 적용 이전 스크롤|디바운스 적용 이전 함수 호출횟수 디버깅|
|---|---|
|<center> <img src = "https://github.com/user-attachments/assets/9f6d8607-b3ee-4e7c-991e-5cf8579a5954" width = "120%" height = "120%" > </center>|<center> <img src = "https://github.com/user-attachments/assets/9d2471be-2998-449f-8178-475df77b11f3" width = "70%" height = "70%" > </center>|
|스크롤 시 버벅임이 발생|한 번 ScrollView의 바닥에 다다랐을 때, 평균적으로 18회 정도의 호출이 일어남|

|디바운스 적용 이후 스크롤|디바운스 적용 이후 함수 호출횟수 디버깅|
|---|---|
|<center> <img src = "https://github.com/user-attachments/assets/4c856ea6-07ea-4ca1-b937-efdbf880394e" width = "120%" height = "120%" > </center>|<center> <img src = "https://github.com/user-attachments/assets/578d539c-3ce2-4117-9330-789cbdc9e84f" width = "70%" height = "70%" > </center>|
|버벅임이 없어짐|호출횟수가 줄었음을 알 수 있다.|

1. 실행중인 workItem이 있다면 취소 시킨다.
2. workItem 을 생성한다.
3. 0.3초 후 실행 시킨다.
4. 하나의 이벤트에 대해 1번의 호출만 일어나게 된다.

```swift
if offsetY > contentHeight - height {

    workItem이?.cancel()
    
    workItem이 = DispatchWorkItem { [weak self] in
        fetchMoreData()
        tableView.reloadData()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem이!)
}
```

## 2. Async/Await를 이용한 코드 재사용성 증가

1. (문제 인식) 같은 fetch 함수를 여러 곳에서 호출. (HomeViewController.swift, RevokeViewController.swift, 등 PuppyInfo를 호출하는 여러 ViewController가 존재. 시간상 본인 파트에 해당하는 부분에만 코드를 적용 )
2. Async/Await 를 이용해 fetch를 PuppyInfoService 라는 class의 타입 함수로 구현
3. viewWillAppear 에서 함수를 호출하여, View에 접근할 때마다 fetch를 호출하여 강아지 정보를 업데이트함

```swift
@MainActor
static func fetchPuppyInfo() async throws -> PuppyInfoResponse? {
    guard let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else { return nil }
    
    return try await AF.request( K.String.puppymodeLink + "/puppies",
                headers: [
                    "accept": "*/*",
                    "Authorization": "Bearer " + accessToken
                ])
    .serializingDecodable(PuppyInfoResponse.self)
    .value
}
```

```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Task {
        if let puppyInfo = try await PuppyInfoService.fetchPuppyInfo() {
            configure(puppy: puppyInfo.result)
        }
    }
}
```

## 3. UIButton 컴포넌트 제작

1. (문제 인식) 설정 화면에는 동일 스타일 버튼 존재한다. 이 버튼의 차이점은 버튼내 이름 뿐이다.
2. ArrowSettingButton 라는 UIButton을 상속받는 Class를 만들고, setTitle() 함수를 통해 각각 이름만 서로 바뀌게 만들었다.
3. 장점, 디자인 피드백 때, 폰트가 수정되거나 버튼의 위치를 조절해야하는 경우가 생겼을 때, 유용했다.

적용 예시
```swift
    //Terms of Service
    public lazy var termsOfServiceButton = ArrowSettingButton()
    //Privacy Policy
    public lazy var privacyPolicyButton = ArrowSettingButton()
    //Revoke
    public lazy var revokeButton = ArrowSettingButton()

    termsOfServiceButton.setTitle(text: "이용약관")
    privacyPolicyButton.setTitle(text: "개인정보 처리 동의")
    revokeButton.setTitle(text: "탈퇴하기")
```

### 전체 시연 영상 링크
https://youtu.be/3n0UB5gy4kM?si=xlhlhn2Jb3BG2ZtP <br>
https://www.youtube.com/watch?v=3XgiBklE6A4 <br>

# iOS 팀원 명단
| 마티 / 김미주 | 푸린 / 김민지 | 봉석 / 박준석 | 루디 / 이승준 |
| --- | --- | --- | --- |
| <center> <img width="150px" src="https://avatars.githubusercontent.com/u/133081015?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/90819894?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/112086285?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/54970536?v=4" /></center> |
| **[@alwn8918](https://github.com/alwn8918)** | **[@m1nzez](https://github.com/m1nzez)** | **[@ YBSeok](https://github.com/YBSeok)** | **[@Rudy-009](https://github.com/Rudy-009)** |
