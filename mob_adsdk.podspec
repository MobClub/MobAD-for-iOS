Pod::Spec.new do |spec|
  spec.name         = "mob_adsdk"
  spec.version      = "2.0.2"
  spec.summary      = "A powerful ad sdk from Mob."
  spec.homepage     = "http://www.mob.com/"
  spec.license      = "MIT"
  spec.author       = { "lishzh" => "lishzh@yoozoo.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.source       = { :http => 'https://dev.ios.mob.com/files/download/mobad/MobAD_For_iOS_v2.0.2.zip' }

  spec.vendored_frameworks = "MobAD/MobAD.framework", "MobAD/Channels/BUAdSDK/BUAdSDK.framework"
  spec.vendored_libraries = "MobAD/Channels/GDTMobSDK/libGDTMobSDK.a"
  spec.source_files  = "MobAD/Channels/GDTMobSDK/*.h"
  spec.resources = "MobAD/MobAD.bundle", "MobAD/Channels/BUAdSDK/BUAdSDK.bundle"
  spec.libraries = "resolv", "xml2"
  spec.dependency "MOBFoundation"

end
