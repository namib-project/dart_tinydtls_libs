Pod::Spec.new do |s|
  s.name             = 'dart_tinydtls_libs'
  s.version          = '0.1.1'
  s.summary          = 'tinydtls for Flutter apps.'
  s.description      = <<-DESC
  Provides tinyDTLS binaries for adding DTLS support to Flutter apps.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Jan Romann' => 'jan.romann@uni-bremen.de' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
