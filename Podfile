# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Flicker' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Flicker

    pod 'Alamofire'
    pod 'AlamofireObjectMapper', '~> 4.0'
	pod 'SDWebImage'

  target 'FlickerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FlickerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

end
