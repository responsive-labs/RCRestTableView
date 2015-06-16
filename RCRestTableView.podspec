Pod::Spec.new do |s|
  s.name             = "RCRestTableView"
  s.version          = "0.1.2"
  s.summary          = "A short description of RCRestTableView."
  s.description      = <<-DESC
                       An optional longer description of RCRestTableView

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/serluca/RCRestTableView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Luca Serpico" => "serpicoluca@gmail.com" }
  s.source           = { :git => "https://github.com/serluca/RCRestTableView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/serluca'

  # Platform setup
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  
  s.source_files  = "Pod/Classes/**/*.{h,m}"
  s.public_header_files = 'Pod/Classes/RCRestTableView.h', 'Pod/Classes/RCRestTableViewTypes.h','Pod/Classes/RCRestTableViewKeys.h'
  s.dependency "ReactiveCocoa", '~> 2.5'
  s.dependency "SZTextView"

end
