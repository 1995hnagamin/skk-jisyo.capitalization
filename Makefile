TARGET = SKK-JISYO.capitalization

$(TARGET): dict.txt
	skkdic-expr2 $< > $@

dict.txt: xml2dict.rb
	bundle exec ruby xml2dict.rb

clean:
	rm -rf dict.txt $(TARGET)
