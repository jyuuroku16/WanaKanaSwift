Pod::Spec.new do |spec|
  spec.name             = 'WanaKanaSwift'
  spec.version          = '1.3.0'
  spec.summary          = 'A Swift library for detecting and transliterating Hiragana, Katakana, and Romaji'
  spec.description      = <<-DESC
                      WanaKanaSwift is a Swift port of the WanaKana JavaScript library, 
                      providing utility methods for detecting and transliterating between 
                      Hiragana, Katakana, and Romaji.
                      DESC
  spec.homepage         = 'https://github.com/jyuuroku16/WanaKanaSwift'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'jyuuroku' => 'jyuurokuu@gmail.com' }
  spec.source           = { :git => 'https://github.com/jyuuroku16/WanaKanaSwift.git', :tag => spec.version.to_s }
  
  spec.ios.deployment_target = '12.0'
  spec.osx.deployment_target = '10.15'
  
  spec.swift_version = '6.0'
  spec.source_files = 'Sources/WanaKanaSwift/**/*'
end 