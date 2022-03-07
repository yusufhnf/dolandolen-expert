# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/yusufhnf/DolanDolen-CorePodSpecs'
target 'dolandolen' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  workspace 'Modularization'

    # Pods for dolandolen
    pod 'Toast-Swift', '~> 5.0.1'
    pod 'Kingfisher', '~> 7.0'
    pod 'Alamofire', '~> 5.4'
    pod 'RxSwift', '6.2.0'
    pod 'RxCocoa', '6.2.0'
    pod 'SwiftLint'
    
    pod 'Core'

    target 'Game' do
      project '../Game/Game'
    end

    target 'GameFavourite' do
      project '../GameFavourite/GameFavourite'
    end

    target 'Common' do
      project '../Common/Common'
    end

    target 'dolandolenTests' do
      inherit! :search_paths
      # Pods for testing
    end

    target 'dolandolenUITests' do
      # Pods for testing
    end

  end
