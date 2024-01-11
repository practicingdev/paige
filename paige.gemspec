PKG_FILES = Dir.glob([
  'bin/*',
  'lib/**/*.rb',
  'data/**/*',
  "LICENSE",
  "agpl-3.0.txt"
])

Gem::Specification.new do |s|
  s.name        = "paige"
  s.version     = "0.0.1"
  s.summary     = "Paige!"
  s.description = "Likely vaporware alternative API to PrawnPDF"
  s.authors     = ["Gregory Brown"]
  s.email       = "gregory@practicingdeveloper.com"
  s.files       = PKG_FILES

  s.licenses = ['AGPL-3.0', 'Nonstandard']
end
