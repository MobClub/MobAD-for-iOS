Pod::Spec.new do |s|
  s.name         = 'mob_adsdk'
  s.version      = '2.0.6.1'
  s.summary      = 'A powerful ad sdk from MobTech.'
  s.homepage     = 'http://www.mob.com/'
  s.license      = 'MIT'
  s.author       = { 'lishzh' => 'lishzh@yoozoo.com' }
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.source       = { :http => 'https://dev.ios.mob.com/files/download/mobad/MobAD_For_iOS_v2.0.6.1.zip' }
  
  s.frameworks = 'ImageIO', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate'
  s.libraries = 'xml2', 'c++', 'resolv', 'z', 'sqlite3'
  s.default_subspecs = 'MobAD'
  s.dependency 'MOBFoundation'

  # Core Module
  s.subspec 'MobAD' do |sp|
    sp.vendored_frameworks = 'MobAD/MobAD.framework'
    sp.resources = 'MobAD/MobAD.bundle'
  end

  # Channels
  s.subspec 'MobADPlat' do |sp|
    # GDT
    sp.subspec 'GDT' do |spg|
      spg.source_files  = 'MobAD/Channels/GDTMobSDK/*.h'
      spg.vendored_frameworks = 'MobAD/Channels/GDTMobSDK/MGADConnector.framework'
      spg.vendored_libraries = 'MobAD/Channels/GDTMobSDK/libGDTMobSDK.a'
      spg.dependency 'mob_adsdk/MobAD'
    end

    # BUD
    sp.subspec 'BUD' do |spb|
      spb.vendored_frameworks = 'MobAD/Channels/BUAdSDK/MBADConnector.framework', 'MobAD/Channels/BUAdSDK/BUAdSDK.framework'
      spb.resources = 'MobAD/Channels/BUAdSDK/BUAdSDK.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end

    # KS
    sp.subspec 'KS' do |spb|
      spb.vendored_frameworks = 'MobAD/Channels/KSAdSDK/MKADConnector.framework', 'MobAD/Channels/KSAdSDK/KSAdSDK.framework'
      spb.resources = 'MobAD/Channels/KSAdSDK/KSAdSDK.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end
  end
end
