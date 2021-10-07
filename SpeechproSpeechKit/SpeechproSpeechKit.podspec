Pod::Spec.new do |s|
  s.name         = "SpeechproSpeechKit"
  s.version      = "0.0.1"
  s.summary      = "Speech recognition, text-to-speech and diarization Framework"
  s.homepage     = "https://cp.speechpro.com/home"
  s.license      = "MIT"
  s.author             = { "alexandrasoloshcheva" => "soloshcheva@speechpro.com" }
  s.platform     = :ios, "9.0"
  s.source   = { :git => 'https://github.com/STC-VoiceKey/stc-speechkit-ios.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.source_files = 'SpeechproSpeechKit/**/*.{h,m,c}'    
  s.public_header_files = 'SpeechproSpeechKit/*.h'
end
