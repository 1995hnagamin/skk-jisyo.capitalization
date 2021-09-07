# coding: euc-jp
# frozen_string_literal: true

require 'nokogiri'
require './libjisyo'

outfile = File.open('dict.txt', 'w', encoding: 'EUC-JP')

sources = Dir['dict/*.xml']

sources.each do |filename|
  doc = Nokogiri::XML(File.open(filename, 'r', encoding: 'EUC-JP'))

  doc.xpath('/jisyo/ca').each do |ca|
    word, yomi = get_word_yomi(ca)
    annotation = get_annotation(ca)

    annot = annotation ? ";#{annotation}" : ''
    outfile.puts "#{yomi} /#{word}#{annot}/"
  end
end
