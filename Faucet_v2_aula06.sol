    /*
    SPDX-License-Identifier: CC-BY-4.0
    (c) Desenvolvido por Jeff Prestes
    This work is licensed under a Creative Commons Attribution 4.0 International License.
    */
    pragma solidity 0.8.19;

    /// @author Vitor Giacometti
    /// @title Estudando o conceito para Faucet
    contract Faucet_v2 {

        mapping(address=>uint8) public viewContrato;
        
        uint8 valorTotal;

        event viewChegouNoLimite(address paraQuem, uint8 quanto);

        // @notice atualizar a quantidade de views em um contrato
        // @dev incrementar o contrato incrementa o valor do acumulador a um endereco ethereum.
        // @return valor atual do valorTotal
        function atribuirValor() public returns (uint256) {
            valorTotal++;
            viewContrato[msg.sender] = valorTotal;
            emit viewChegouNoLimite(msg.sender, valorTotal);
            return valorTotal;
        
        }

    }