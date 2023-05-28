.name 		"Abel-"
.comment	"Even simpler abel"

	sti r1, %:one, %1
	sti r1, %:two, %1
	ld %0, r1
	fork %:two

one:
	live %1
	zjmp %:one

two:
	live %1
	zjmp %:two
