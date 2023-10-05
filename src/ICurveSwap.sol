pragma solidity ^0.8.19;

interface ICurveSwap {

    function add_liquidity(
        // 3 for 3Pool
        uint256[3] calldata amounts,
        uint256 min_mint_amount
    ) external;

    function remove_liquidity_one_coin(
        uint256 _token_amount,
        int128 i,
        uint256 min_amount
    ) external;

}