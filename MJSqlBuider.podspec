Pod::Spec.new do |s|
s.name             = "MJSqlBuider"
s.version          = "1.0.0"
s.summary          = "A marquee view used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/haoshili/MJSqlBuider.git"
# s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Hsj" => "haoshili123@qq.com" }
s.source           = { :git => "https://github.com/haoshili/MJSqlBuider.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/NAME'

s.platform     = :ios, '9.0'
# s.ios.deployment_target = '10.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true

s.source_files = 'MJSqlBuider/*'
# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
