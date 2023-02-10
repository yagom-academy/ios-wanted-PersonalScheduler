# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PersonalScheduler' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PersonalScheduler
  pod 'KakaoSDKCommon'  # 필수 요소를 담은 공통 모듈
  pod 'KakaoSDKAuth'  # 사용자 인증
  pod 'KakaoSDKUser'  # 카카오 로그인, 사용자 관리

  pod 'FirebaseMessaging'
  pod 'FirebaseFirestore'
  pod 'FirebaseAnalytics'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
    end
end
