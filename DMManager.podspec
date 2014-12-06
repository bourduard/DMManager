
Pod::Spec.new do |s|

  s.name         = "DMManager"
  s.version      = "1.0.1"
  s.summary      = "Description of DMManager will be soon."
  s.homepage     = "https://github.com/alexj70/DMManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexandr Zhovty" => "alexandr.zhovty@icloud.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/alexj70/DMManager.git", :tag => "1.0.1" }
  s.source_files  = "Classes", "Classes/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/*.h"
  s.frameworks  = "Foundation", "CoreData"
  s.requires_arc = true

end
