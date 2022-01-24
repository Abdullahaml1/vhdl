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
