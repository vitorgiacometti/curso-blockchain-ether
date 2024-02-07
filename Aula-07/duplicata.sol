// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "./owner.sol";
import "./titulo.sol";


//Deploy do contrato 0xC37b82735B06389f4e63af578153614760E95265
/**
 * @title Duplicata
 * @dev Operacoes de uma Duplicata
 * @author Vitor Giacometti
 */
 contract Duplicata is Titulo, Owner {

    string _emissor;
    string public _sacado;
    string[] public _titular;
    uint256 immutable _dataEmissao;
    uint256 _valor;
    uint8 immutable _decimais;
    uint256 _vencimentoPagamento;
    uint256 _prazoPagamento;


    constructor() {
        _emissor = "Escrituradora Comercial LTDA";
        _dataEmissao = block.timestamp;
        _valor = 100000000;
        _decimais = 2;
        _vencimentoPagamento;
        _prazoPagamento = _dataEmissao + 90 days;
        emit NovoPrazoPagamento(_dataEmissao, _prazoPagamento);
    }

    /**
     * @dev Retorna o valor nominal.
     */
    function valorNominal() external view returns (uint256) {
        return _valor;
    }

    /**
     * @dev Retorna o nome do Emissor.
     */
    function nomeEmissor() external view returns (string memory) {
        return _emissor;
    }

    /**
     * @dev Retorna a data da emissao.
     */
    function dataEmissao() external view returns (uint256) {
        return _dataEmissao;
    }

  

    function valorDuplicatadataEmissao() external view returns (uint256) {
        return _dataEmissao;
    }
  
    function mudarSacado(string memory sacado) external onlyOwner returns (string memory) {
        _sacado = sacado;        
        return _sacado;
    }

    function mudarTitular(string memory titular) external onlyOwner returns (string[] memory) {
        _titular.push(titular);
        return _titular;
    }


 }