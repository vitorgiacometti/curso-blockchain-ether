/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.19;

import "./IERC20.sol";


/**
 * @title MyErc20
 * @dev Consulta Padrao ERC20
 * @author Vitor Giacometti
 */
contract Contrato  {
    

    function MyBalanceOf(address token_, address transacao_ ) public view returns(uint256) {
        
        IERC20 ierc20 = IERC20(token_);        
        return ierc20.balanceOf(transacao_);

    }

    function saldoTransacao(address transacao_)public view returns(uint256) {
        
        return transacao_.balance;
    }


}
