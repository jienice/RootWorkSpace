platform :ios, '13.0'
source 'https://cdn.cocoapods.org/'

use_frameworks!
inhibit_all_warnings!

workspace 'RootWorkSpace.xcworkspace'

def ui_pods
  
  pod 'XLForm'
  pod 'DZNEmptyDataSet'
  pod 'MJRefresh'
  pod 'MBProgressHUD'
  pod 'TZImagePickerController'
  pod 'WMPageController'
  pod 'SKPhotoBrowser'
  pod 'YYText'
  pod 'HMSegmentedControl'
  pod 'CollectionKit'
  pod 'RTRootNavigationController'
  pod 'SnapKit'
  pod 'RxKeyboard'
  pod 'Popover'
end


def basic_pods

  pod 'SwiftyJSON'
  pod 'Moya/RxSwift'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'RxGesture'
  pod 'RxOptional'
  pod 'RxTheme'
  pod 'Action'
  pod 'Kingfisher'
  pod 'SwiftDate'
  pod 'DeviceKit'

  pod 'SwifterSwift/Foundation'
  pod 'SwifterSwift/UIKit'
  pod 'SwifterSwift/Dispatch'
  pod 'SwifterSwift/SceneKit'
end

target 'BasicFramework' do
  project 'BasicFramework/BasicFramework.xcodeproj'
  basic_pods
end


target 'ListFramework' do
  project 'ListFramework/ListFramework.xcodeproj'
  ui_pods
  basic_pods
end


target 'IMDemo' do
  project 'IMDemo/IMDemo.xcodeproj'
  ui_pods
  basic_pods
  pod 'CocoaAsyncSocket'
end

target 'FrameworkDemo' do
  project 'FrameworkDemo/FrameworkDemo.xcodeproj'
  ui_pods
  basic_pods
end


# https://stackoverflow.com/questions/54704207/the-ios-simulator-deployment-targets-is-set-to-7-0-but-the-range-of-supported-d
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end
