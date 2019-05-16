#
# Be sure to run `pod lib lint DataAdapterSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DataAdapterSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DataAdapterSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ly/DataAdapterSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ly' => '1090336995@qq.com' }
  s.source           = { :git => 'https://github.com/ly/DataAdapterSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.frameworks = "VideoToolbox", "AudioToolbox", "CoreMedia"

  s.libraries = "c++", "iconv", "z","resolv",'xml2',"stdc++.6.0.9"
  s.vendored_libraries = 'DataAdapterSDK/Depend/sdk_output/Lib/*.a','DataAdapterSDK/stdc++/libstdc++.6.0.9.tbd'

  s.vendored_frameworks ='DataAdapterSDK/Depend/DssSDK/DssSDK.framework'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'false','CLANG_CXX_LIBRARY' => "libstdc++",'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO','OTHER_LDFLAGS' => '-ObjC -all_load'}
  s.dependency "SBJson", "2.2.3"
  s.dependency 'XMLDictionary'
  s.dependency "OAStackView" , "~> 1.0.1"
  s.dependency 'MBProgressHUD'
  s.dependency 'AFNetworking'
  s.dependency 'MQTTClient'
  s.dependency 'KissXML'
  s.resources = 'DataAdapterSDK/Depend/sdk_output/Bundle/*.bundle'
  # s.resource_bundles = {
  #   'DataAdapterSDK' => ['DataAdapterSDK/Assets/*.png']
  # }

  s.public_header_files = 'DataAdapterSDK/Depend/sdk_output/**/*.h'
  s.source_files = 'DataAdapterSDK/Depend/sdk_output/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
