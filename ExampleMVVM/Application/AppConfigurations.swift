import Foundation

// 앱 실행에 필요한 환경 설정 값을 Info.plist에서 불러오는 설정 전용 클래스
final class AppConfiguration {
    
    // Info.plist의 ApiKey 값을 읽어오는 lazy property
    // 값이 없으면 크래시 발생
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    // Info.plist에서 API 요청의 기본 baseURL을 읽어오는 설정값
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    // 이미지 리소스 요청을 위한 baseURL
    lazy var imagesBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
}
