# coding: euc-jp

require 'nokogiri'

outfile = File.open('dict.txt', 'w', encoding: 'EUC-JP')

doc = Nokogiri::XML(File.open('dict.xml', 'r', encoding: 'EUC-JP'))

doc.xpath('/jisyo/ca').each do |ca|
  word = ca.at('word').text
  yomi = ca.at('yomi')&.text || word.downcase.gsub(/[^a-z]/, '')

  annotation = ca.at('annotation')&.text
  annot = annotation ? ";#{annotation}" : ''
  outfile.puts "#{yomi} /#{word}#{annot}/"
end