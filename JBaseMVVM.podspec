#
# Be sure to run `pod lib lint JBaseMVVM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JBaseMVVM'
  s.version          = '0.1.0'
  s.summary          = '必须填写JBaseMVVM的说明.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jingxuelong/JBaseMVVM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jingxuelong' => 'jingxuelong0037@126.com' }
  s.source           = { :git => 'https://github.com/jingxuelong/JBaseMVVM.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  # s.static_framework = true

  s.source_files = 'JBaseMVVM/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JBaseMVVM' => ['JBaseMVVM/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'RxSwift', '6.5.0'
  s.dependency 'RxCocoa', '6.5.0'
 # s.subspec "SubName" do |ss|
 #   ss.source_files = ["JBaseMVVM/Classes/SubName/**/*"]
 #   ss.dependency 'AFNetworking', '~> 2.3'
 # end

end
