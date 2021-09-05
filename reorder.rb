# coding: euc-jp
# frozen_string_literal: true

require 'nokogiri'
require 'rexml/document'

words = nil

File.open('dict/jawiki-latest.xml', 'r', encoding: 'EUC-JP') do |file|
  doc = Nokogiri::XML(file)
  words = doc.xpath('/jisyo/ca').map do |ca|
    ca.at('word').text
  end
end

words.sort_by!(&:downcase)

doc = REXML::Document.new
doc << REXML::XMLDecl.new('1.0', 'EUC-JP')
root = REXML::Element.new('jisyo')
doc.add_element(root)

words.each do |word|
  ca = REXML::Element.new('ca')

  w = REXML::Element.new('word')
  w.add_text(word)
  ca.add_element(w)

  root.add_element(ca)
end

pretty = REXML::Formatters::Pretty.new
pretty.compact = true
sio = StringIO.new
pretty.write(doc, sio)

outfile = File.open('./dict/jawiki-latest-reordered.xml', 'w', encoding: 'EUC-JP')
outfile.puts(sio.string.gsub('</ca>', "</ca>\n"))
