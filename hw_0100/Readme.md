# Homework 0b0100

**Elvis Wolcott**

---

## Implimentation

### `mux32`

For the mux, I recalled that we used a binary tree design in the past to create a 4:1 and 8:1 mux. Because the mux operator works with any width, I didn't need to go past it for my basic mux. However, implimenting all the levels (4:1, 8:1, 16:1) would be slightly tedious. I realized recursion should be able to solve this issue (assuming the tooling supports it). Thankfully. it worked after a bit of syntax checking and troubleshooting.

### `add32`

For my adder I used a ripple-carry design. This is easy to impliment using the full adder from the lab and follows the same design as our 3-bit adder but with a generate statement to acomodate the much larger size. I plan to attempt some of the more complex designs next weekend on my own, but had a lot going on this weekend.

## Testing

### `mux32`

I started by testing the 2:1 mux (recursive base case) to ensure my syntax was correct and that it behaved identical to the provided mux as it should.

For the 32-bit mux, I tested by filling the inputs with 32-bit random numbers and then going through all values of select. To verify I pulled out the expected value by shifting through the inputs in 32-bit chunks. To double check my test bench logic I had it print out the results for tests even if it passed and noticed initially they were almost all 0 because I was not ORing together the random bits as I added on to the input. I was able to fix this and the test still passed!

### `add32`

Testing the adder was fairly straightforwards.

Because the full adder can be comepletely tested with a truth table and was field tested in lab1, I trust that it works.

Based on this assumption, I just wanted to test that each connection was correct and the overflow carry works. To test this I iterated through bit shifting a single 1 through the entire 32-bit range and adding the together. I compared the result with the result given by verilog's `+` operator. I did the same for 1<<31 explicitly checking for the overflow carry and then for completelness I checked using 128 pairs of random 32-bit numbers using `$urandom`.

## Running the tests

The makefile has targets for running the testing the mux and adder.

```
make test_mux
make test_adder
```
