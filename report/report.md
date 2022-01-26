% CSE635, Assignment 3, Main Memory, and Virtual Memory
% Abdullah Aml;2101398
% 

# 1-Bit Latch

## Test Strategy
| D | Clk | q | qbar | comment                                 |
|---+-----+---+------+-----------------------------------------|
| 1 |   1 | 1 |    0 | problem reacting to change in D         |
| 1 |   0 | 1 |    0 | The latch does not hold D               |
| 0 |   1 | 0 |    1 | Deasserting D (do latch depend on clk?) |
| 1 |   0 | 0 |    1 | output is not changing at the clock     |

## Test Output
```
Time is now: 15 ns, D=1, clk=1, Actual q=1, Actual nq=0 Test PASSED
Time is now: 30 ns, D=1, clk=0, Actual q=1, Actual nq=0 Test PASSED
Time is now: 45 ns, D=0, clk=1, Actual q=0, Actual nq=1 Test PASSED
Time is now: 60 ns, D=1, clk=0, Actual q=0, Actual nq=1 Test PASSED
```

![1-bit Latch](../1_bit_latch/sim.png){#bit-latch}


# Address Decoder 2

## Test Strategy
| address | decode | comment                                             |
|---------+--------+-----------------------------------------------------|
|       7 |     10 | Corner case for first case.                         |
|      15 |     01 | Corner case for second case (changing both bits).   |
|      17 |     01 | does save the output(out side the range behaviour). |
|      20 |     11 | problem reacting to change in D.                    |


## Test Output
```
Time is now: 15 ns, address=7, decode=10, Actual decode=10 Test PASSED
Time is now: 30 ns, address=15, decode=01, Actual decode=01 Test PASSED
Time is now: 45 ns, address=17, decode=01, Actual decode=01 Test PASSED
Time is now: 60 ns, address=20, decode=11, Actual decode=11 Test PASSED
```

![Address Decoder_2](../decoder_2/sim.png){#decoder_2}

# Mux

## Test Strategy
| abcd |  s | z | comment                       |
|------+----+---+-------------------------------|
| 0001 | 11 | 1 | Not selecting the last input. |
| 0001 | 00 | 0 | stuck at 1 output.            |
| 1000 | 00 | 1 | not selecting first input.    |
| 0010 | 10 | 1 | Not selecting third input.    |
| 1000 | 01 | 0 | stuck at 1 fault.             |
| 1100 | 01 | 1 | Not selecting second input.   |

## Test Output
```
Time is now: 15 ns, a,b,c,d=0001, s=11, z=1, Actual z=1 Test PASSED
Time is now: 30 ns, a,b,c,d=0001, s=00, z=0, Actual z=0 Test PASSED
Time is now: 45 ns, a,b,c,d=1000, s=00, z=1, Actual z=1 Test PASSED
Time is now: 60 ns, a,b,c,d=0010, s=10, z=1, Actual z=1 Test PASSED
Time is now: 75 ns, a,b,c,d=1000, s=01, z=0, Actual z=0 Test PASSED
Time is now: 90 ns, a,b,c,d=1100, s=01, z=1, Actual z=1 Test PASSED
```

![Mux simulation](../mux/sim.png){#mux}

# ALU

## Test Strategy
| op |    a |    b |    c | comment                        |
|----+------+------+------+--------------------------------|
| 01 | 1100 | 1101 | 1111 | all ones test.                 |
| 01 | 0011 | 1100 | 0111 | maximum range(positive) of c.  |
| 01 | 1111 | 0111 | 1000 | maximum range (negative )of c. |
| 01 | 0011 | 0011 | 0000 | getting zero output.           |
| 00 | 1100 | 1101 | 1001 | random test.                   |
| 00 | 0011 | 1100 | 1111 | all ones test of c.            |
| 00 | 1111 | 1001 | 1000 | maximum range (negative )of c. |
| 00 | 0011 | 0100 | 0111 | maximum range(positive) of c.  |
| 00 | 0011 | 1101 | 0000 | getting zero output.           |
| 10 | 0011 | 1111 | 1101 | not changing op.               |
| 10 | 0111 | 0001 | 0111 | max range(positive).           |
| 10 | 1100 | 0010 | 1000 | max range(negative).           |
| 10 | 1101 | 1110 | 0110 | not considering sign.          |
| 11 | 1101 | 1110 | 0000 | not considering sign.          |
| 11 | 0111 | 0001 | 0111 | max range(positive).           |
| 11 | 1000 | 0001 | 1000 | max range(negative).           |
| 11 | 0111 | 1101 | 1110 | random example.                |

## Test output
```
time is now: 15 ns, op=sub, a=1100, b=1101, c=-1, actual c=1111 test passed
time is now: 30 ns, op=sub, a=0011, b=1100, c=7, actual c=0111 test passed
time is now: 45 ns, op=sub, a=1111, b=0111, c=-8, actual c=1000 test passed
time is now: 60 ns, op=sub, a=0011, b=0011, c=0, actual c=0000 test passed
time is now: 75 ns, op=add, a=1100, b=1101, c=-7, actual c=1001 test passed
time is now: 90 ns, op=add, a=0011, b=1100, c=-1, actual c=1111 test passed
time is now: 105 ns, op=add, a=1111, b=1001, c=-8, actual c=1000 test passed
time is now: 120 ns, op=add, a=0011, b=0100, c=7, actual c=0111 test passed
time is now: 135 ns, op=add, a=0011, b=1101, c=0, actual c=0000 test passed
time is now: 150 ns, op=mul, a=0011, b=1111, c=-3, actual c=1101 test passed
time is now: 165 ns, op=mul, a=0111, b=0001, c=7, actual c=0111 test passed
time is now: 180 ns, op=mul, a=1100, b=0010, c=-8, actual c=1000 test passed
time is now: 195 ns, op=mul, a=1101, b=1110, c=6, actual c=0110 test passed
time is now: 210 ns, op=div, a=1101, b=1110, c=1, actual c=0000 failed,
error messages:  not considering sign.
time is now: 225 ns, op=div, a=0111, b=0001, c=7, actual c=0111 test passed
time is now: 240 ns, op=div, a=1000, b=0001, c=-8, actual c=1000 test passed
time is now: 255 ns, op=div, a=0111, b=1101, c=-2, actual c=1110 test passed
```

![ALU](../alu/sim.png){#alu}


