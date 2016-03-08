#
# Be sure to run `pod lib lint KMCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KMCache"
  s.version          = "0.1.7"
  s.summary          = "A high performance cache with key-value memory storage."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = 'A high performance cache with key-value memory storage. User can use KMCache to cache any objects they want. Two types for releasing caches, by time and by size.'

  s.homepage         = "https://github.com/Mioke/KMCache"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Mioke" => "mioke0428@gmail.com" }
  s.source           = { :git => "https://github.com/Mioke/KMCache.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'KMCache/*'
#s.resource_bundles = {
#   'KMCache' => ['Pod/Assets/*.png']
# }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
