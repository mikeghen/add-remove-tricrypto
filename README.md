# Add Remove Liquidity from TricryptoUSDC Curve Pool
This repo tests adding and removing liquidity from the TricryptoUSDC Curve pool. There's an failure on the removal of liquidity. 

The call to `remove_liquidity_one_coin` does no state changes and does not revert. Passing in arguments that should fail also does not fail.

There are two tests that both fail. In each case, `remove_liquidity_one_coin` is called and nothing happens. This shows up as:
```
├─ [1849] 0x7F86Bf177Dd4F3494b841a37e810A34dD56c829B::remove_liquidity_one_coin(466388307333452426013 [4.663e20], 0, 0) 
│   └─ ← ()
```
In the tests. Regardless of the arguments, the call does not fail.


### Test

```shell
$ forge test --fork-url <your-rpc> --etherscan-api-key <your-etherscan-api-key>
```