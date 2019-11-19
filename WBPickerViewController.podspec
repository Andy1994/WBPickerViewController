#
# Be sure to run `pod lib lint WBPickerViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBPickerViewController'
  s.version          = '0.1.0'
  s.summary          = 'Convenient using PickerView. Custom display column by given data.'

  s.description      = <<-DESC
Convenient using pickerView. Custom display column by given data. You can simple create 1~3 column pickerView.
                       DESC

  s.homepage         = 'https://github.com/Andy1994/WBPickerViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andy1994' => 'wangwenbomx@gmail.com' }
  s.source           = { :git => 'https://github.com/Andy1994/WBPickerViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'WBPickerViewController/*.swift'
  
end
