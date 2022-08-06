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
  s.source_files = '../third_party/tinydtls'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.script_phases = [
    { :name => 'Precompile',
      :script => 'cmake -S ${PODS_TARGET_SRCROOT}/../third_party/tinydtls -B ${PODS_TARGET_SRCROOT}/../third_party/tinydtls',
      :execution_position => :before_compile
    },
  ]

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
