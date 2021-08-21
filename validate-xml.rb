require 'nokogiri'

xsd = Nokogiri::XML::Schema(File.read('skk-jisyo.xsd'))

sources = Dir['dict/*.xml']

results = sources.map do |filename|
  puts filename

  doc = Nokogiri::XML(File.open(filename, 'r', encoding: 'EUC-JP'))
  errors = xsd.validate(doc)
  if !errors.empty?
    errors.each do |e|
      puts e.message
    end
    success = false
  else
    puts "OK"
  end

  puts

  errors.empty?
end

exit(results.all?)
