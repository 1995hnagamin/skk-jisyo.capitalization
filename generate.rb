# coding: euc-jp

require 'csv'

data = CSV.read('dict.csv', headers:true, encoding: 'EUC-JP')

outfile = File.open('dict.txt', 'w', encoding: 'EUC-JP')

data.each do |row|
    word = row['word']
    key = word.downcase.gsub(/[^a-z]/, '')
    annot = row['annot'] ? ";#{row['annot']}" : ""
    outfile.puts "#{key} /#{word}#{annot}/"
end
