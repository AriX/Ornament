Pod::Spec.new do |s|
  s.name         = 'Ornament'
  s.version      = '0.3.5'
  s.summary      = 'Ornament is a set of APIs used to provide visual ornamentation for iOS apps.'
  s.homepage     = 'https://www.github.com/jordanekay/Ornament'
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.author = {
    'Jordan Kay' => 'jordanekay@mac.com'
  }
  s.source = {
    :git => 'https://github.com/jordanekay/Ornament.git',
    :tag => s.version.to_s
  }
  s.license = {
    :type => 'MIT'
  }
  s.source_files = 'Ornament/Ornament/**/*.{h,m,swift}'
  s.dependency     'Mensa'
  s.dependency     'TTSwitch'
  s.dependency     'KGNoise'
  s.dependency     'libextobjc/EXTScope'
end
