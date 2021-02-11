TARGET = SKK-JISYO.capitalization

$(TARGET): dict.txt
	skkdic-expr2 $< > $@

dict.txt: generate.rb dict.csv
	ruby generate.rb

clean:
	rm -rf dict.txt $(TARGET)