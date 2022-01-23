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
