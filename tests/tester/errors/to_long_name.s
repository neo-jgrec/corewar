	.name "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lectus elit, efficitur ac purus non, scelerisque rhoncus leo. Donec tempus arcu nunc, sit amet faucibus dui varius in. Sed scelerisque eget enim ut iaculis. Proin erat dui, imperdiet nec tempor eget, rutrum ac magna. Etiam quis ullamcorper libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis ante nibh, facilisis in risus et, lacinia imperdiet purus."
	.comment "L'amer noir."

	sti r1, %:hi, %1

hi:	live %234
	ld %0, r3
	zjmp %:hi
