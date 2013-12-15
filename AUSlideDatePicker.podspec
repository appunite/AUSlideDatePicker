#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "AUSlideDatePicker"
  s.version      = "0.1.0"
  s.summary      = "A short description of AUSlideDatePicker."
  s.description  = <<-DESC
                    An optional longer description of AUSlideDatePicker

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "http://www.appunite.com"
  s.license      = 'MIT'
  s.author       = { "Piotr Adamczak" => "piotr.adamczak@appunite.com", "Emil Wojtaszek" => "emil@appunite.com" }
  s.source       = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true
  s.source_files = 'Classes/**/*.{h,m}'
end
