require 'rexml/document'
require 'stringio'

data = File.open('dict/jawiki-latest.txt')

doc = REXML::Document.new
doc << REXML::XMLDecl.new('1.0', 'EUC-JP')
root = REXML::Element.new('jisyo')
doc.add_element(root)

data.each_line.map(&:chomp).each do |row|
    ca = REXML::Element.new('ca')

    w = REXML::Element.new('word')
    w.add_text(row)
    ca.add_element(w)

    root.add_element(ca)
end

pretty = REXML::Formatters::Pretty.new
pretty.compact = true
sio = StringIO.new
pretty.write(doc, sio)

outfile = File.open('./dict/jawiki-latest.xml', 'w', encoding: 'EUC-JP')
outfile.puts(sio.string.gsub("</ca>", "</ca>\n"))