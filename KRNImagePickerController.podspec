Pod::Spec.new do |s|

  s.name         = "KRNImagePickerController"
  s.version      = "0.0.2"
  s.summary      = "KRNImagePickerController is a simple class that helps you to send email from iOS application"

  s.homepage     = "https://github.com/ulian-onua/KRNImagePickerController"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author              = { "Julian Drapaylo" => "ulian.onua@gmail.com" }
  #s.social_media_url   = "http://www.linkedin.com/in/julian-drapaylo"


  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ulian-onua/KRNImagePickerController.git", :tag => "0.0.2" }


  s.source_files  = "KRNImagePickerController/*.{h,m}"
  s.public_header_files = "KRNImagePickerController/*.h"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

end
