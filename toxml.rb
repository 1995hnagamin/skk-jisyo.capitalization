require 'csv'
require 'rexml/document'
require 'stringio'

data = CSV.read('dict.csv', headers:true, encoding: 'EUC-JP')

doc = REXML::Document.new
doc << REXML::XMLDecl.new('1.0', 'EUC-JP')
root = REXML::Element.new('jisyo')
doc.add_element(root)

data.each do |row|
    ca = REXML::Element.new('ca')

    w = REXML::Element.new('word')
    w.add_text(row['word'])
    ca.add_element(w)

    if row['annot'] then
      an = REXML::Element.new('annotation')
      an.add_text(row['annot'])
      ca.add_element(an)
    end

    root.add_element(ca)
end

pretty = REXML::Formatters::Pretty.new
pretty.compact = true
sio = StringIO.new
pretty.write(doc, sio)

str = sio.string.gsub("</ca>", "</ca>\n")

outfile = File.open('dict.xml', 'w', encoding: 'EUC-JP')
outfile.puts(str)
