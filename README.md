# Corewar

## Introduction

The Corewar Epitech project is about champion fighting simulation.
Pseudo-assembly programs are run in a virtual machine, and the goal is to call last the special instruction `live`.

The Corewar is the project that ends the first year of Epitech,
It is a competition between the different groups of the promotion.
The prizes are Corewar sweaters for the best team.

We won !! 🏆

### Virtual Machine (alias VM)

- The arene consists of 4096 bytes;
- The arene is circular, meaning that if a champion try to go out of bounds, he's back on the other side of the arene;
- Each instruction executes only at the end of its cycle (and waits for its entire duration);

### Champions

The `bytecode` of the champions are made thanks to the `asm` part of the project. It translate the `.s` files into `.cor` binary used by the **VM** to run the champion.

## Usage

A champion program is a pseudo-assembly program, with the following syntax:

```asm
# This is a comment
    .name "<champion name>"
    .comment "<champion description>"

label: # This is a label
    live r1 # This is an instruction
    ld %42, r2 # Load the direct value 42 into the register r2
    ld 42, r3 # Load the indirect value at address 42 into the register r3
    zjmp %:label # Jump to the label
```

You can then compile your champion program with the `asm` program:

```sh
asm/asm champion.s
ls -l champion.cor
```

You can then use it with the `corewar` program:

```sh
corewar/corewar champion.cor champion.cor champion2.cor
```

## List of Instructions

Here is the translation of the provided mnemonic instructions and their effects into English:

| Mnemonic |                               Effects                        |
|:----------:| ----------------------------------------------------------- |
| 0x01 (live)|Followed by 4 bytes representing the player number. This instruction indicates that this player is alive. (no parameter encoding byte).                                    |
|0x02 (ld)|This instruction takes 2 parameters, the second of which must be a register (not the PC). It loads the value of the first parameter into the register. This operation modifies the carry. ``ld 34,r3`` loads `REG_SIZE` bytes from the address `(PC + (34 % IDX_MOD))` into register r3.|
|0x03 (st)|This instruction takes 2 parameters. It stores (`REG_SIZE` bytes) the value of the first argument (always a register) into the second. `st r4,34` stores the value of r4 at the address `(PC + (34 % IDX_MOD))`, `st r3,r8` copies r3 into r8.|
|0x04 (add)|This instruction takes 3 registers as parameters, adds the contents of the first two, and puts the result into the third. This operation modifies the carry. `add r2,r3,r5` adds r2 and r3 and puts the result into r5.|
|0x05 (sub)|Same as add but subtracts.|
|0x06 (and)|p1 & p2 -> p3, where the third parameter is always a register. This operation modifies the carry. `and r2,%0,r3` puts r2 & 0 into r3.|
|0x07 (or)|Same as and but with bitwise OR (`\|` in C).|
|0x08 (xor)|Same as and but with bitwise XOR (`^` in C).|
|0x09 (zjmp)|This instruction is not followed by bytes to describe parameters. It always takes an index (`IND_SIZE`) and jumps to that index if the carry is one. If the carry is zero, zjmp does nothing but consumes the same time. `zjmp %23` sets `(PC + (23 % IDX_MOD))` in the PC if carry == 1.|
|0x0A (ldi)|This operation modifies the carry. `ldi 3,%4,r1` reads `IND_SIZE` bytes at the address: `(PC + (3 % IDX_MOD))`, adds 4 to this value. Let's call this sum S. It reads `REG_SIZE` bytes at the address `(PC + (S % IDX_MOD))` and copies them into r1. Parameters 1 and 2 are indices.|
|0x0B (sti)|`sti r2,%4,%5` sti copies `REG_SIZE` bytes from r2 to the address `(4 + 5)`. Parameters 2 and 3 are indices. If parameters 2 or 3 are registers, their contents are used as an index.|
0x0C (fork)|This instruction is not followed by bytes to describe parameters. It always takes an index and creates a new program that runs from the address:`(PC + (first parameter % IDX_MOD))`<br>`fork %34` creates a new program. The new program inherits various states from the parent.|
0x0D (lld)|Like ld without `%IDX_MOD`. This operation modifies the carry.|
0x0E (lldi)|Like ldi without `%IDX_MOD`. This operation modifies the carry.|
0x0F (lfork)|Like fork without `%IDX_MOD`. This operation modifies the carry.|
0x10 (aff)|This instruction is followed by a parameter byte to describe the parameters. It takes a register as a parameter and displays the character whose ASCII code is present in that register. (a modulo 256 is applied to the ASCII code, and the character is displayed on the standard output).<br>Example: `ld %42,r3` then `aff r3` displays '*' on the standard output.|
