Pod::Spec.new do |s|
  s.name         = 'mob_adsdk'
  s.version      = '2.1.7'
  s.summary      = 'A powerful ad sdk from MobTech.'
  s.homepage     = 'http://www.mob.com/'
  s.license      = 'MIT'
  s.author       = { 'lishzh' => 'lishzh@yoozoo.com' }
  s.platform     = :ios
  s.ios.deployment_target = '11.0'
  s.source       = { :http => 'https://dev.ios.mob.com/files/download/mobad/MobAD_For_iOS_v2.1.7.zip' }
  
  s.frameworks = 'WebKit','Security','QuartzCore','CoreData','ImageIO', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate', 'MessageUI', 'SafariServices'
  s.libraries = 'xml2', 'c++', 'resolv', 'z', 'sqlite3'
  s.default_subspecs = 'MobAD'
  # s.dependency 'FCommon'

  # Core Module
  s.subspec 'MobAD' do |sp|
    sp.vendored_frameworks = 'SDK/MobAD/MobAD.framework','SDK/Required/FCommon.framework'
    sp.resources = 'SDK/MobAD/MobAD.bundle'
  end

  # Channels
  s.subspec 'MobADPlat' do |sp|
    # GDT
    sp.subspec 'GDT' do |spg|
      spg.source_files  = 'SDK/MobAD/Channels/GDTMobSDK/*.h'
      spg.vendored_frameworks = 'SDK/MobAD/Channels/GDTMobSDK/MGADConnector.framework'
      spg.vendored_libraries = 'SDK/MobAD/Channels/GDTMobSDK/libGDTMobSDK.a'
      spg.dependency 'mob_adsdk/MobAD'
    end

    # BUD
    sp.subspec 'BUD' do |spb|
      spb.vendored_frameworks = 'SDK/MobAD/Channels/BUAdSDK/MBADConnector.framework', 'SDK/MobAD/Channels/BUAdSDK/BUAdSDK.framework', 'SDK/MobAD/Channels/BUAdSDK/BUFoundation.framework'
      spb.resources = 'SDK/MobAD/Channels/BUAdSDK/BUAdSDK.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end

    # KS
    sp.subspec 'KS' do |spb|
      spb.vendored_frameworks = 'SDK/MobAD/Channels/KSAdSDK/MKADConnector.framework', 'SDK/MobAD/Channels/KSAdSDK/KSAdSDK.framework'
      spb.resources = 'SDK/MobAD/Channels/KSAdSDK/KSAdSDK.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end

    # BQT
    sp.subspec 'BQT' do |spb|
      spb.vendored_frameworks = 'SDK/MobAD/Channels/BQTAdSDK/MDADConnector.framework', 'SDK/MobAD/Channels/BQTAdSDK/BaiduMobAdSDK.framework'
      spb.resources = 'SDK/MobAD/Channels/BQTAdSDK/baidumobadsdk.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end

    # GOE
    sp.subspec 'GOE' do |spb|
      spb.vendored_frameworks = 'SDK/MobAD/Channels/GOEAdSDK/MOADConnector.framework', 'SDK/MobAD/Channels/GOEAdSDK/GoogleAppMeasurement.framework' , 'SDK/MobAD/Channels/GOEAdSDK/GoogleMobileAds.framework' ,'SDK/MobAD/Channels/GOEAdSDK/GoogleUtilities.xcframework' ,'SDK/MobAD/Channels/GOEAdSDK/nanopb.xcframework' ,  'SDK/MobAD/Channels/GOEAdSDK/PromisesObjC.xcframework' 
     # spb.resources = 'SDK/MobAD/Channels/BQTAdSDK/baidumobadsdk.bundle'
      spb.dependency 'mob_adsdk/MobAD'
    end

  end
end
