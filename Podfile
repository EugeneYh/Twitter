# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Twitter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Twitter
	pod 'SnapKit', '~> 5.0.0'
	pod 'Firebase/Auth'
	pod 'Firebase/Database'
	pod 'Firebase/Storage'
  pod 'SDWebImage', '~> 5.0'
end

post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
             config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
             config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
         end
     end
  end
