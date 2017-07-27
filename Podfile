project 'zenigame/zenigame.xcodeproj/'

platform :ios, '8.0'
post_install do | installer |
 require 'fileutils'
   FileUtils.cp_r('Pods/Target Support Files/Pods-zenigame/Pods-zenigame-acknowledgements.plist', 'zenigame/zenigame/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
 end
target 'zenigame' do
  use_frameworks!
  pod 'SwiftLint', '~> 0.18.0'  
  pod 'PureLayout'
  pod 'FontAwesomeKit'
  pod 'IQKeyboardManager'
  pod 'SwiftOverlays'
  pod 'SlideMenuControllerSwift', '~> 3.0.1'
  pod 'Kingfisher', '~> 3.0'
  pod 'Alamofire', '~> 4.4'
  pod 'OHHTTPStubs/Swift'
  pod 'ObjectMapper', '~> 2.2'
  pod 'LFLiveKit', '~> 2.6'

  target 'zenigameTests' do
    inherit! :search_paths
  end

  target 'zenigameUITests' do
    inherit! :search_paths
  end

end
