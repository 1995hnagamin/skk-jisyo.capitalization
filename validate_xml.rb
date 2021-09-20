# frozen_string_literal: true

require 'optparse'
require 'nokogiri'
require './libjisyo'

def calc_mode(mode)
  hash = {
    'verbose' => [true, true],
    'silent' => [false, false],
    'compact' => [true, false]
  }
  hash[mode]
end

def put_errors(diag_tuple, filename, mode)
  errors, ok_msg = diag_tuple

  showerr, showok = calc_mode(mode)

  if showerr
    errors.each do |e|
      puts "#{filename}: #{e}"
    end
  end
  puts ok_msg if errors.empty? && showok

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
    _, yomi = get_word_yomi(ca)
    errors << "error: got '#{yomi}' after '#{cur_yomi}'" if yomi < cur_yomi
    cur_yomi = yomi
  end

  [errors, 'sorted: OK']
end

# command line options

opt = OptionParser.new
opt.on('--mode [VALUE]') { |v| v }

params = {
  mode: 'verbose'
}
opt.parse!(ARGV, into: params)

# body

sources = Dir['dict/*.xml']

results = sources.map do |filename|
  if params[:mode] == 'verbose'
    puts
    puts filename
  end

  doc = Nokogiri::XML(File.open(filename, 'r', encoding: 'EUC-JP'))

  check_items = [
    xsd.validate(doc),
    check_word_worder(doc)
  ]
  check_items.map { |t| put_errors(t, filename, params[:mode]) }.all?
end

exit(results.all?)
