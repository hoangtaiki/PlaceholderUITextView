Pod::Spec.new do |s|
  s.name             = 'PlaceholderUITextView'
  s.version          = '2.0.0'
  s.summary          = 'A feature-rich UITextView subclass with built-in placeholder support and accessibility.'
  s.description      = <<-DESC
                       PlaceholderUITextView is a drop-in replacement for UITextView that adds native placeholder functionality.
                       
                       Features:
                       • Native placeholder support with plain text and attributed text
                       • Full accessibility support with VoiceOver
                       • Smooth animations and modern Swift API design
                       • Automatic sizing and constraint management
                       • iOS 15+ support with backwards compatibility
                       • Comprehensive unit test coverage
                       DESC

  s.homepage         = 'https://github.com/hoangtaiki/PlaceholderUITextView'
  s.screenshots      = ['https://raw.githubusercontent.com/hoangtaiki/PlaceholderUITextView/master/Images/demo.gif']
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hoangtaiki' => 'duchoang.vp@gmail.com' }
  s.source           = { :git => 'https://github.com/hoangtaiki/PlaceholderUITextView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hoangtaiki'

  # Platform support
  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  # Source files
  s.source_files = 'Source/**/*.{swift,h}'
  s.public_header_files = 'Source/**/*.h'
  
  # Frameworks
  s.frameworks = 'UIKit', 'Foundation'
  
  # Build settings
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '5.0',
    'OTHER_SWIFT_FLAGS' => '-Xfrontend -warn-long-function-bodies=100 -Xfrontend -warn-long-expression-type-checking=100'
  }
  
  # Documentation
  s.documentation_url = 'https://github.com/hoangtaiki/PlaceholderUITextView/blob/master/README.md'
  
  # Subspecs for modular architecture (if needed in future)
  # s.default_subspec = 'Core'
  # s.subspec 'Core' do |core|
  #   core.source_files = 'Source/Core/**/*.swift'
  # end
end
