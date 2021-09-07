# coding: euc-jp
# frozen_string_literal: true

def get_word_yomi(ca_elem)
  word = ca_elem.at('word').text
  yomi = ca_elem.at('yomi')&.text || word.downcase.gsub(/[^a-z]/, '')
  [word, yomi]
end

def get_annotation(ca_elem)
  ca_elem.at('annotation')&.text
end
