build:
	-for i in *.asm; do echo "Assembling $$i..."; lc3as $$i; done
	[ -d assembled/ ] || mkdir assembled/
	mv *.obj assembled/
	mv *.sym assembled/

run:
	lc3sim -s tetris.script