import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        
        // iOS 15 이상 스타일 적용
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance() // 네비게이션바의 appearance을 담은 객체 생성
            appearance.configureWithOpaqueBackground() // 배경을 완전 불투명으로 설정
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 네비게이션바의 타이틀 글씨 색 설정(흰색)
            appearance.backgroundColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37.0/255.0, alpha: 1.0) // 네비게이션바의 배경 색 설정(거의 검정)
            
            // 앱 전체의 네비게이션바에 이 appearance를 적용
            UINavigationBar.appearance().standardAppearance = appearance // 기본 상태
            UINavigationBar.appearance().scrollEdgeAppearance = appearance // 스크롤 끝에서 나타나는 모습
        }
        // iOS 15 미만 스타일 적용
        else {
            UINavigationBar.appearance().barTintColor = .black // 네비게이션바 배경색 설정(검정)
            UINavigationBar.appearance().tintColor = .white // 버튼 및 아이콘 색 설정(흰색)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // 타이틀 클씨 색(흰색)
        }
    }
}

extension UINavigationController {
    // 상태바(상단 시간/배터리/신호 표시)의 글씨 색을 담당
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
