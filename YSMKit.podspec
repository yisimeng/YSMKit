#
# Be sure to run `pod lib lint YSMKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'YSMKit'
    s.version          = '0.1.0'
    s.summary          = 'A short description of YSMKit.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/yisimeng/YSMKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yisimeng' => '465386131@qq.com' }
    s.source           = { :git => 'https://github.com/yisimeng/YSMKit.git' }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'YSMKit/Classes/**/*'

    
    #s.subspec 'YSMCategory' do |c|
    #    c.source_files = 'YSMKit/Classes/YSMCategory/*'
    #end
    
    #s.subspec 'YSMCustom' do |c|
    #   c.source_files = 'YSMKit/Classes/YSMCustom/**/*'
    #   c.dependency 'YSMKit/YSMCategory'
    #end
    
    #s.subspec 'YSMNetwork' do |net|
    #   net.source_files = 'YSMKit/Classes/YSMNetwork/*'
    #   net.dependency 'AFNetworking', '~> 3.0'
    #end
    
    
    
    # s.resource_bundles = {
    #   'YSMKit' => ['YSMKit/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
     s.dependency 'AFNetworking'
end
