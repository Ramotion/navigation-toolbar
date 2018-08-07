
Pod::Spec.new do |s|

  s.name             = 'Navigation-Toolbar'
  s.version          = '1.0.0'
  s.summary          = 'Amazing navigation.'
  s.license          = 'MIT'
  s.homepage         = 'https://github.com/Ramotion/navigation-toolbar'
  s.author           = { 'Juri Vasylenko' => 'juri.v@ramotion.com' }
  s.ios.deployment_target = '10.0'
  s.source           = { :git => 'https://github.com/Ramotion/navigation-toolbar.git', :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
end
