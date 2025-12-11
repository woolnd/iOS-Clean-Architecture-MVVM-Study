import UIKit

@UIApplicationMain // 앱 진입점

// UIResponder: 터치, 키보드 같은 Event를 처리하는 기본 클래스
// UIApplicationDelegate: 앱 생명주기 이벤트를 받기 위한 프로토콜
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer() // 앱 전체 의존성을 조립하는 컨테이너 인스턴스(Network, Scene DIContainer등을 만든다.)
    var appFlowCoordinator: AppFlowCoordinator? // 앱의 첫 화면 및 플로우를 관리하는 코디네이터
    var window: UIWindow? // iOS에서 앱이 그려지는 최상위 원도우
    
    // MARK: - 앱이 처음 실행되고 거의 제일 먼저 호출되는 메서드
    // 이 메소드에서 UI 세팅 및 첫 화면 구성을 한다.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        AppAppearance.setupAppearance() // 전역 네비게이션바/상태바 스타일 세팅
        
        window = UIWindow(frame: UIScreen.main.bounds) // 현재 디스플레이 크기만큼 윈도우 생성
        let navigationController = UINavigationController() // 네비게이션 기반 앱이기에 Root에서 UINavigationController 인스턴스 생성

        window?.rootViewController = navigationController // 모든 화면은 네비게이션 컨트롤러 아래에서 push/pop으로 이동한다.
        
        // FlowCoordinator에 네비게이션 컨트롤러와 DIContainer를 넘김
        appFlowCoordinator = AppFlowCoordinator(
            navigationController: navigationController,
            appDIContainer: appDIContainer
        )
        appFlowCoordinator?.start() // start() 호출 -> 이 안에서 어떤 Scene을 첫 화면으로 띄울지 결정
        window?.makeKeyAndVisible() // window를 사용자에게 보이게 만들고 true 리턴(원도우를 우선 설정후 보이게 하기 위함)
    
        return true
    }

    // MARK: - 앱이 백그라운드 들어갈 때 CoreData 컨텍스트 저장
    // 임시 작업 공간(컨텍스트)에 쌓인 변경사항을 실제 DB에 저장
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }
}
