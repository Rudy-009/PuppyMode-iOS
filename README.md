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

## Pagination 개선
이전 프로젝트에서 구현한 페이지네이션의 문제
1. 호출을 제어하지 못하여, 1,2,3,4,5,6,7,8,9,10,... 이 되어야 하는데 1,2,3,1,2,3,1,2,3,1,2,3,4,5,6,4,5,6,4,5,6,4,5,6 인 결과가 나타남. 같은 인덱스 호출을 하지 못하게 제어해야함.
2. ScrollView의 바닥에 다다랐을 때, 7,8회 정도의 API를 호출함.

### 문제1.
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

### 전체 시연 영상 링크
https://youtu.be/3n0UB5gy4kM?si=xlhlhn2Jb3BG2ZtP


# iOS 팀원 명단
| 마티 / 김미주 | 푸린 / 김민지 | 봉석 / 박준석 | 루디 / 이승준 |
| --- | --- | --- | --- |
| <center> <img width="150px" src="https://avatars.githubusercontent.com/u/133081015?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/90819894?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/112086285?v=4" /></center> | <center> <img width="150px" src="https://avatars.githubusercontent.com/u/54970536?v=4" /></center> |
| **[@alwn8918](https://github.com/alwn8918)** | **[@m1nzez](https://github.com/m1nzez)** | **[@ YBSeok](https://github.com/YBSeok)** | **[@Rudy-009](https://github.com/Rudy-009)** |
