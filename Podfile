# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GetDonor' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GetDonor
	
  pod 'youtube-ios-player-helper', '~> 0.1.4'
  pod 'AccountKit'
  pod 'ReachabilitySwift'
  pod 'SDWebImage', '~> 4.0'
  target 'GetDonorTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GetDonorUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
