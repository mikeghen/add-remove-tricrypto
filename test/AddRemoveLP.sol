// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {IERC20} from "../src/IERC20.sol";
import {ICurveSwap} from "../src/ICurveSwap.sol";

contract CounterTest is Test {

    address internal constant USDC_ADDRESS = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; 
    address internal constant TRI_CURVE_POOL = 0x7F86Bf177Dd4F3494b841a37e810A34dD56c829B; // TricryptoUSDC
    
    IERC20 internal constant USDC = IERC20(USDC_ADDRESS);
    IERC20 internal constant TRICRYPTO = IERC20(TRI_CURVE_POOL);
    
    uint256 internal constant DEPOSIT_AMOUNT = 500_000_000_000; // 500k USDC
    
    address payable internal alice = payable(makeAddr("alice"));

    function setUp() public {
        deal(USDC_ADDRESS, alice, DEPOSIT_AMOUNT);
    }

    function test_addRemoveLiquidity() public  {
        // deposit USDC into the curvePool
        vm.prank(alice);
        USDC.approve(address(TRI_CURVE_POOL), DEPOSIT_AMOUNT);
        uint256[3] memory amounts;
        amounts[0] = DEPOSIT_AMOUNT;
        amounts[1] = 0;
        amounts[2] = 0;
        vm.prank(alice);
        ICurveSwap(TRI_CURVE_POOL).add_liquidity(amounts, 0);

        // All USDC was deposited
        assertEq(USDC.balanceOf(alice), 0);

        // remove liquidity
        uint256 lpBalance = TRICRYPTO.balanceOf(alice);
        vm.prank(alice);
        ICurveSwap(TRI_CURVE_POOL).remove_liquidity_one_coin(lpBalance, 0, 0);

        // USDC was recovered
        assertGt(USDC.balanceOf(alice), 0);
    }

    function testFail_addRemoveLiquidity() public {
        // Alice removes liquidity tokens she does not have
        assertEq(TRICRYPTO.balanceOf(alice), 0);

        vm.prank(alice);
        ICurveSwap(TRI_CURVE_POOL).remove_liquidity_one_coin(100, 0, 0);

    }
}
