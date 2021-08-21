require 'nokogiri'

xsd = Nokogiri::XML::Schema(File.read('jisyo.xsd'))
doc = Nokogiri::XML(File.read('dict.xml'))

errors = xsd.validate(doc)
if errors.empty?
  puts 'OK'
  exit(0)
end

errors.each do |e|
  puts e.message
end
