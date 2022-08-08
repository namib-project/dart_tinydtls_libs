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
  s.source_files = './Classes/tinydtls/**/*'
  s.pod_target_xcconfig  = { 'USER_HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/../third_party/tinydtls"/**' }
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.script_phases = [
    { :name => 'Copy tinydtls files',
      :script => 'cp ${PODS_TARGET_SRCROOT}/../third_party/tinydtls ${PODS_TARGET_SRCROOT}/Classes/tinydtls',
      :execution_position => :before_compile
    },
    { :name => 'Precompile',
      :script => 'cmake -S ${PODS_TARGET_SRCROOT}/Classes/third_party/tinydtls -B ${PODS_TARGET_SRCROOT}/Classes/third_party/tinydtls',
      :execution_position => :before_compile
    }
    # {
    #   :name => 'Copy Header Files',
    #   :script => 'cp ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/tinydtls.h ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/sha2/tinydtls.h && cp ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/tinydtls.h ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/platform-specific/tinydtls.h && cp ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/dtls_prng.h ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/platform-specific/dtls_prng.h && cp ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/dtls_debug.h ${PODS_TARGET_SRCROOT}/../third_party/tinydtls/platform-specific/dtls_debug.h',
    #   :execution_position => :before_compile
    # }
  ]

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
