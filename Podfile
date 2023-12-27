platform :ios, '10.0'

def survey_pods
  pod 'Swinject', '2.8.3'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'RxGesture'
  pod 'NSObject+Rx'
  pod "PromiseKit", "~> 8"
end


target 'nimble_assignment' do
  use_frameworks!
  survey_pods
  pod 'SnapKit', '5.6.0'
  pod 'Alamofire', '5.6.4'
  pod 'IQKeyboardManagerSwift'
  pod 'KeychainAccess'
  pod 'Kingfisher'
  pod 'SkeletonView'
  pod 'SideMenu'
  pod 'Connectivity'

  target 'nimble_assignmentTests' do
    inherit! :search_paths
    survey_pods
    pod 'Nimble'
    pod 'Quick'
    pod 'Cuckoo'
  end

  target 'nimble_assignmentUITests' do
    # Pods for testing
  end
end
