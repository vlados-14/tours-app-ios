
def shared_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ReactorKit'
  pod 'RxDataSources'
  pod 'SDWebImage'
end

target 'task-ios' do
  use_frameworks!
  inhibit_all_warnings!

  shared_pods
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
