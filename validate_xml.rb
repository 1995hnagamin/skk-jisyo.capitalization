# frozen_string_literal: true

require 'nokogiri'

def put_errors(diag_tuple)
  errors, ok_msg = diag_tuple
  errors.each do |e|
    puts e
  end
  puts ok_msg if errors.empty?
  errors.empty?
end

# XML Schema Validator.
class Validator
  def initialize(filename)
    @xsd_filename = filename
    @xsd = Nokogiri::XML::Schema(File.read(filename))
  end

  def validate(doc)
    errors = @xsd.validate(doc)
    [errors, "#{@xsd_filename}: OK"]
  end
end

xsd = Validator.new('skk-jisyo.xsd')

def check_word_worder(doc)
  errors = []

  cur_yomi = ''
  doc.xpath('/jisyo/ca').each do |ca|
    word = ca.at('word').text
    yomi = ca.at('yomi')&.text || word.downcase.gsub(/[^a-z]/, '')
    errors << "error: got '#{yomi}' after '#{cur_yomi}'" if yomi < cur_yomi
    cur_yomi = yomi
  end

  [errors, 'sorted: OK']
end

sources = Dir['dict/*.xml']

results = sources.map do |filename|
  puts
  puts filename

  doc = Nokogiri::XML(File.open(filename, 'r', encoding: 'EUC-JP'))

  check_items = [
    xsd.validate(doc),
    check_word_worder(doc)
  ]
  check_items.map { |t| put_errors(t) }.all?
end

exit(results.all?)
