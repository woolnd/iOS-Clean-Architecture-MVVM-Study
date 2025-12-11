import Foundation

// 전역 의존성 조립소 역할
// 앱 전체 레이어가 필요한 의존성을 생성하고, Scene 단위 DIContainer에게 전달하는 핵심 역할
final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration() // Info.plist에서 API Key, Base URL 등을 가져오는 설정 객체
    
    // MARK: - Network
    // UseCase나 Repository는 직접 네트워크를 만들지 않음 → 이 DIContainer가 만든 DataTransferService를 주입받아서 사용
    lazy var apiDataTransferService: DataTransferService = {
        
        // API 요청의 전체 기본 환경을 정의
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: [
                "api_key": appConfiguration.apiKey,
                "language": NSLocale.preferredLanguages.first ?? "en"
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config) // 실제 HTTP 요청을 보내고 Data(바이트)만 반환하는 가장 로우 레벨 네트워크 계층
        return DefaultDataTransferService(with: apiDataNetwork) // 네트워크 Data를 앱이 이해할 수 있는 구조로 변환하는 상위 계층 서비스
    }()
    
    // 이미지 다운로드용 DataTransferService
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.imagesBaseURL)!
        )
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    // MoviesScene에 필요한 의존성을 AppDIContainer가 조립해서 전달해주는 역할
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        let dependencies = MoviesSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService,
            imageDataTransferService: imageDataTransferService
        )
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
}
