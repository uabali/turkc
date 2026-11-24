SCANNER = scanner

all: $(SCANNER)

lex.yy.c: scanner.l
	flex scanner.l

$(SCANNER): lex.yy.c
	$(CC) lex.yy.c -o $(SCANNER)

# Runs the scanner on the sample programs; fails if it cannot tokenize them.
test: $(SCANNER)
	@for f in test1.tc test2.tc; do \
		echo "== $$f"; tr -d "\r" < $$f | ./$(SCANNER) || exit 1; \
	done

clean:
	rm -f $(SCANNER)

.PHONY: all test clean
