.name 		"Abel--"
.comment	"Simplest, most innocent abel"

	st r1, 13
	ld %0, r1
one:
	live %1
	zjmp %:one
