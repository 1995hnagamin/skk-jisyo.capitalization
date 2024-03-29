TARGET = \
	SKK-JISYO.capitalization \
	SKK-JISYO.capitalization.utf8

all:	$(TARGET)

SKK-JISYO.capitalization: dict.txt etc/head.txt
	cat etc/head.txt > $@
	skkdic-expr2 $< >> $@

SKK-JISYO.capitalization.utf8: SKK-JISYO.capitalization
	nkf -w $< > $@

dict.txt: xml2dict.rb $(shell find dict)
	bundle exec ruby xml2dict.rb

clean:
	rm -rf dict.txt $(TARGET)
