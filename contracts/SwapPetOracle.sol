// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/SwapPetOracle.sol
pragma solidity ^0.7.0; 

// import "@nomiclabs/buidler/console.sol";
import "hardhat/console.sol";

/// @title   Price Oracle of Swap.Pet.
/// @author  Swap.Pet@pm.me  
/// @dev     price on base/quote, swapper for exchange between base and quote. 
contract SwapPetOracle { 
    address public oracle;
    address public swapper;

    constructor(address oracle_,address swapper_) public {
        console.log("Deploying a Oracle with swapper:", swapper_);
        oracle = oracle_;
        swapper = swapper_;
    } 

    function setSwapper(address swapper_) public {
        console.log("Changing swapper from '%s' to '%s'", swapper, swapper_);
        swapper = swapper_;
    }
    /// @notice the price(scaled by 1e18) of base_/quote_.
    // / @returns return 0 if false or not support the base_/quote_. 
    function price(address base_,address quote_) external view returns (uint256){
        console.log("price of '%s' / '%s':'%i'", base_, quote_,10);
        return 10;
    }

    /// @notice swap Check amountIn_ tokenIn_ to amountOut_ tokenOut_.
    // / @returns 0 with do nothing or do not support base_/quote_ swap.
    function swap(address tokenIn_,address tokenOut_,uint256 amountIn_) external returns (uint256 amountOut_){
        amountOut_ = 123;
        console.log("swap '%s' from '%i' to '%i'", tokenIn_, amountIn_, amountOut_); 
        return 123;
    }
}  


// A mock oracle used for testing.
contract MockOracle is OracleInterface, Testable {
    // Represents an available price. Have to keep a separate bool to allow for price=0.
    struct Price {
        bool isAvailable;
        int256 price;
        // Time the verified price became available.
        uint256 verifiedTime;
    }

    // The two structs below are used in an array and mapping to keep track of prices that have been requested but are
    // not yet available.
    struct QueryIndex {
        bool isValid;
        uint256 index;
    }

    // Represents a (identifier, time) point that has been queried.
    struct QueryPoint {
        bytes32 identifier;
        uint256 time;
    }

    // Reference to the Finder.
    FinderInterface private finder;

    // Conceptually we want a (time, identifier) -> price map.
    mapping(bytes32 => mapping(uint256 => Price)) private verifiedPrices;

    // The mapping and array allow retrieving all the elements in a mapping and finding/deleting elements.
    // Can we generalize this data structure?
    mapping(bytes32 => mapping(uint256 => QueryIndex)) private queryIndices;
    QueryPoint[] private requestedPrices;

    constructor(address _finderAddress, address _timerAddress) public Testable(_timerAddress) {
        finder = FinderInterface(_finderAddress);
    }

    // Enqueues a request (if a request isn't already present) for the given (identifier, time) pair.

    function requestPrice(bytes32 identifier, uint256 time) external {
        require(_getIdentifierWhitelist().isIdentifierSupported(identifier));
        Price storage lookup = verifiedPrices[identifier][time];
        if (!lookup.isAvailable && !queryIndices[identifier][time].isValid) {
            // New query, enqueue it for review.
            queryIndices[identifier][time] = QueryIndex(true, requestedPrices.length);
            requestedPrices.push(QueryPoint(identifier, time));
        }
    }

    // Pushes the verified price for a requested query.
    function pushPrice(
        bytes32 identifier,
        uint256 time,
        int256 price
    ) external {
        verifiedPrices[identifier][time] = Price(true, price, getCurrentTime());

        QueryIndex storage queryIndex = queryIndices[identifier][time];
        require(queryIndex.isValid, "Can't push prices that haven't been requested");
        // Delete from the array. Instead of shifting the queries over, replace the contents of `indexToReplace` with
        // the contents of the last index (unless it is the last index).
        uint256 indexToReplace = queryIndex.index;
        delete queryIndices[identifier][time];
        uint256 lastIndex = requestedPrices.length - 1;
        if (lastIndex != indexToReplace) {
            QueryPoint storage queryToCopy = requestedPrices[lastIndex];
            queryIndices[queryToCopy.identifier][queryToCopy.time].index = indexToReplace;
            requestedPrices[indexToReplace] = queryToCopy;
        }
    }

    // Checks whether a price has been resolved.
    function hasPrice(bytes32 identifier, uint256 time) external view returns (bool) {
        require(_getIdentifierWhitelist().isIdentifierSupported(identifier));
        Price storage lookup = verifiedPrices[identifier][time];
        return lookup.isAvailable;
    }

    // Gets a price that has already been resolved.
    function getPrice(bytes32 identifier, uint256 time) external view returns (int256) {
        require(_getIdentifierWhitelist().isIdentifierSupported(identifier));
        Price storage lookup = verifiedPrices[identifier][time];
        require(lookup.isAvailable);
        return lookup.price;
    }

    // Gets the queries that still need verified prices.
    function getPendingQueries() external returns (QueryPoint[] memory) {
        return requestedPrices;
    }

    function _getIdentifierWhitelist() private view returns (IdentifierWhitelistInterface supportedIdentifiers) {
        return IdentifierWhitelistInterface(finder.getImplementationAddress(bytes32("IdentifierWhitelist")));
    }
}

