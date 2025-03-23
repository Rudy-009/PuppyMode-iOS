# 🐶 강아지모드 iOS 🍎

## UMC 7th 데모데이 최우수 수상작 🏆

## 강아지 모드 담당 파트 영상
| Kakao Login | Kakao Signup | Apple Login |
| --- | --- | --- |
|<center> <img src = "https://github.com/user-attachments/assets/1463352c-f031-4046-951c-0d727d318d24" width = "80%" height = "80%"/>  </center>| <center> <img src = "https://github.com/user-attachments/assets/6ac8ebf7-02c0-4da7-b64a-523c029e4300" width = "80%" height = "80%"/> </center> | <center> <img src = "https://github.com/user-attachments/assets/380a0f87-a4fc-4b30-9d59-847ae23351a5" width = "110%" height = "110%"/> </center> | 

| Animation | Kakao Friends | Pagination |
| --- | --- | --- |
|<center> <img src = "https://github.com/user-attachments/assets/6bbdf8d4-8b04-44c5-b893-be53ec256c85" width = "90%" height = "90%"/>  </center>| <center> <img src = "https://github.com/user-attachments/assets/b6cfc560-6c7c-4d26-aa89-bd7646d8f1ab" width = "90%" height = "90%"/> </center> | <center> <img src = "https://github.com/user-attachments/assets/07b861d6-7178-438d-be6a-d99de0d3ab40" width = "90%" height = "90%"/> </center> | 

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

### 해결2. Debounce 를 이용한 이벤트당 호출 횟수 제한

|디바운스 적용 이전 스크롤|디바운스 적용 이전 함수 호출횟수 디버깅|
|---|---|
|<center></center>|<center></center>|
|||

|디바운스 적용 이후 스크롤|디바운스 적용 이후 함수 호출횟수 디버깅|
|---|---|
|<center></center>|<center></center>|
|||

1. 실행중인 throttleWorkItem이 있다면 취소 시킨다.
2. throttleWorkItem 을 생성한다.
3. 0.3초 후 실행 시킨다.
4. 하나의 이벤트에 대해 1번의 호출만 일어나게 된다.

```swift
if offsetY > contentHeight - height {

    throttleWorkItem?.cancel()
    
    throttleWorkItem = DispatchWorkItem { [weak self] in
        fetchMoreData()
        tableView.reloadData()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: throttleWorkItem!)
}
```

## 2. Async/Await를 이용한 코드 재사용성 증가

1. 같은 fetch 함수를 여러 곳에서 호출. (HomeViewController.swift, RevokeViewController.swift, 등 PuppyInfo를 호출하는 여러 ViewController가 존재. 시간상 본인 파트에 해당하는 부분에만 코드를 적용 )
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


### 전체 시연 영상 링크
https://youtu.be/3n0UB5gy4kM?si=xlhlhn2Jb3BG2ZtP

# iOS 팀원 명단
| 마티 / 김미주 | 푸린 / 김민지 | 봉석 / 박준석 | 루디 / 이승준 |
| --- | --- | --- | --- |
| <center> <img width="150px" src="https://avatars.githubusercontent.com/u/133081015?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/90819894?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/112086285?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/54970536?v=4" /></center> |
| **[@alwn8918](https://github.com/alwn8918)** | **[@m1nzez](https://github.com/m1nzez)** | **[@ YBSeok](https://github.com/YBSeok)** | **[@Rudy-009](https://github.com/Rudy-009)** |
