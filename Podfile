platform :ios, '14.0'
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
