
Pod::Spec.new do |s|
  s.name             = "AXToggleTitleContainerController"
  s.version          = "0.1.0"
  s.summary          = "View Controller with Toggling Title View, like the Pixiv for iOS."
  s.description      = <<-DESC
                       View Controller with Toggling Title View, like the Pixiv for iOS.
                       (This software has no relation with Pixiv)
                       DESC
  s.homepage         = "https://github.com/akiroom/AXToggleTitleContainerController"
  s.screenshots     = "https://raw.githubusercontent.com/akiroom/AXToggleTitleContainerController/master/Screenshots/screenshot0.png", "https://raw.githubusercontent.com/akiroom/AXToggleTitleContainerController/master/Screenshots/screenshot1.png", "https://raw.githubusercontent.com/akiroom/AXToggleTitleContainerController/master/Screenshots/screenshot2.png"
  s.license          = 'MIT'
  s.author           = { "Hiroki Akiyama" => "akiyama@akiroom.com" }
  s.source           = { :git => "https://github.com/akiroom/AXToggleTitleContainerController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/akiroom'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'AXToggleTitleContainerController' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
  s.dependency 'UIImageEffects'
end
