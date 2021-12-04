  
  spec.subspec 'Screenshots' do |feature|
    feature.name = 'Screenshots'
    feature.source_files = 'Sources/CrowdinSDK/Features/ScreenshotFeature/**/*.swift'
    feature.dependency 'CrowdinSDK/Core'
    feature.dependency 'CrowdinSDK/CrowdinProvider'
    feature.dependency 'CrowdinSDK/CrowdinAPI'
    feature.dependency 'CrowdinSDK/LoginFeature'
  end
  
  spec.subspec 'RealtimeUpdate' do |feature|
    feature.name = 'RealtimeUpdate'
    feature.source_files = 'Sources/CrowdinSDK/Features/RealtimeUpdateFeature/**/*.swift'
    feature.dependency 'CrowdinSDK/Core'
    feature.dependency 'CrowdinSDK/CrowdinProvider'
    feature.dependency 'CrowdinSDK/CrowdinAPI'
    feature.dependency 'CrowdinSDK/LoginFeature'
  end
  
  spec.subspec 'RefreshLocalization' do |feature|
    feature.name = 'RefreshLocalization'
    feature.source_files = 'Sources/CrowdinSDK/Features/RefreshLocalizationFeature/**/*.swift'
    feature.dependency 'CrowdinSDK/Core'
    feature.dependency 'CrowdinSDK/CrowdinProvider'
    feature.dependency 'CrowdinSDK/CrowdinAPI'
  end
  
  spec.subspec 'LoginFeature' do |feature|
    feature.name = 'LoginFeature'
    feature.source_files = 'Sources/CrowdinSDK/Features/LoginFeature/**/*.swift'
    feature.dependency 'CrowdinSDK/Core'
    feature.dependency 'CrowdinSDK/CrowdinProvider'
    feature.dependency 'CrowdinSDK/CrowdinAPI'
    feature.dependency 'BaseAPI', '~> 0.1.12'
  end
  
  spec.subspec 'IntervalUpdate' do |feature|
    feature.name = 'IntervalUpdate'
    feature.source_files = 'Sources/CrowdinSDK/Features/IntervalUpdateFeature/**/*.swift'
    feature.dependency 'CrowdinSDK/Core'
    feature.dependency 'CrowdinSDK/CrowdinProvider'
    feature.dependency 'CrowdinSDK/CrowdinAPI'
  end
  
  spec.subspec 'Settings' do |settings|
    settings.name = 'Settings'
    settings.source_files = 'Sources/CrowdinSDK/Settings/**/*.swift'
    settings.resources = 'Sources/CrowdinSDK/Resources/Settings/*.{storyboard,xib,xcassets}'
    settings.dependency 'CrowdinSDK/Screenshots'
    settings.dependency 'CrowdinSDK/RealtimeUpdate'
    settings.dependency 'CrowdinSDK/RefreshLocalization'
    settings.dependency 'CrowdinSDK/IntervalUpdate'
    settings.dependency 'CrowdinSDK/Core'
    settings.dependency 'CrowdinSDK/CrowdinProvider'
    settings.dependency 'CrowdinSDK/CrowdinAPI'
    settings.dependency 'CrowdinSDK/LoginFeature'
  end
