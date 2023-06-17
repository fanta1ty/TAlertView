Pod::Spec.new do |s|
  s.name             = 'TAlertView'
  s.version          = '1.0.0'
  s.summary          = 'TAlertView is a flat customizable alertView, written in Swift'
  s.description      = 'TAlertView is a fully customizable and beautifully designed alert view. TAlertView lets you do things such as specify the number of buttons, the color scheme of the view, adding a small image to it, hide the view after a certain time, and more.'
  s.homepage         = 'https://github.com/fanta1ty/TAlertView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'thinhnguyen12389' => 'thinhnguyen12389@gmail.com' }
  s.source           = { :git => 'https://github.com/fanta1ty/TAlertView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.platform = :ios, '12.0'
  s.source_files = 'Sources/TAlertView/**/*.{swift}'
  s.swift_version = '5.0'
  s.resources = 'Sources/TAlertView/Resources/*.xcassets'
end
