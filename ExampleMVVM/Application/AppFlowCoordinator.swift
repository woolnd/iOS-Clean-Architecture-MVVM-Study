import UIKit

// 앱 전체 흐름을 조정하는 Coordinator
final class AppFlowCoordinator {

    var navigationController: UINavigationController // 화면이동을 담당(AppDelegate에서 주입 받음)
    private let appDIContainer: AppDIContainer // 앱 전체 의존성을 만드는 컨테이너(AppDelegate에서 주입 받음)
    // -> FlowCoordinator는 navigation + DI 두 가지 도구를 기반으로 화면을 구성
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    // MARK: - 앱 실행 시 가장 먼저 호출되는 흐름 시작 시점
    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer() // 영화 검색 기능이 포함된 Scene에 필요한 의존성을 생성
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController) // 영화 검색 화면 흐름을 만드는 Coordinator 생성 후 navigationController 주입
        flow.start()
    }
}
