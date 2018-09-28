Pod::Spec.new do |s|

  s.name         = "ISGHttpClient"
  s.version      = "0.6"
  s.summary      = "ISGHttpClient."
  s.description  = <<-DESC
  0.6，强求参数JSON化
                   DESC

  s.homepage     = "https://github.com/Isaaclzg/ISGHttpClient"
  s.license      = "MIT"
  s.author             = { "isaac_gang" => "isaac_gang@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Isaaclzg/ISGHttpClient.git", :tag => "#{s.version}" }
  s.source_files  = "ISGHttpClient", "ISGHttpClient/**/*.{h,m}"

  s.framework = "Foundation"
  s.dependency "AFNetworking", "~> 3.2.1"
  s.dependency "YYCache", "~> 1.0.4"
end
