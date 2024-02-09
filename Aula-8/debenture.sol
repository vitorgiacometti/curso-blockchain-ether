// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "./IERC20.sol";
import "./ownable.sol";

/**
 * @title Debenture
 * @dev Operacoes de uma debenture
 * @author Vitor Giacometti
 * token 0xf89ec215Eb0C393aF2BF1216e0a0cb17474fD953
 */
 contract Debenture is IERC20, Ownable {

    string private myName;
    string private mySymbol;
    uint256 private myTotalSupply;
    uint256 public decimals;
    
    uint256 immutable _dataEmissao;
    uint256 _prazoPagamento;
    uint16 _fracoes;
    string public rating;

    mapping (address=>uint256) balances;
    mapping (address=>mapping (address=>uint256)) ownerAllowances;


    constructor() {
        myName = "VG Token 02 2024";
        mySymbol = "VGT022024";
        decimals = 2;
        _dataEmissao = block.timestamp;
        _prazoPagamento = _dataEmissao + 90 days;
        rating = "BBB-";
        _fracoes = 1000;
        emit NovoPrazoPagamento(_dataEmissao, _prazoPagamento);
        mint(msg.sender, (1000000000 * (10 ** decimals)));
    }
  


    function balanceOf(address tokenOwner) public override view returns(uint256) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint256 amount) public override  hasEnoughBalance(msg.sender, amount) tokenAmountValid(amount) returns(bool) {
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[to] = balances[to] + amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    } 

    function allowance(address tokenOwner, address spender) public override view returns(uint256) {
        return ownerAllowances[tokenOwner][spender];
    }

    function approve(address spender, uint limit) public override returns(bool) {
        ownerAllowances[msg.sender][spender] = limit;
        emit Approval(msg.sender, spender, limit);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override 
    hasEnoughBalance(from, amount) isAllowed(msg.sender, from, amount) tokenAmountValid(amount)
    returns(bool) {
        balances[from] = balances[from] - amount;
        balances[to] += amount;
        ownerAllowances[from][msg.sender] = ownerAllowances[from][msg.sender] - amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        require(account != address(0), "ERC20: mint to the zero address");
        myTotalSupply = myTotalSupply + amount;
        balances[account] = balances[account] + amount;
        emit Transfer(address(0), account, amount);
        return true;
    }

    function burn(address account, uint256 amount) public onlyOwner returns (bool) {
        require(account != address(0), "ERC20: burn from address");
        balances[account] = balances[account] - amount;
        myTotalSupply = myTotalSupply - amount;
        emit Transfer(account, address(0), amount);
        return true;
    }
    
    /**
    * @dev muda o rating
    * @notice dependendo da situacao economica a empresa avaliadora pode mudar o rating
    * @param novoRating novo rating da debenture
    */
    function mudaRating(string memory novoRating) external onlyOwner returns (bool) {
        rating = novoRating;
        return true;
    }

    modifier hasEnoughBalance(address owner, uint amount) {
        uint balance;
        balance = balances[owner];
        require (balance >= amount); 
        _;
    }

    modifier isAllowed(address spender, address tokenOwner, uint amount) {
        require (amount <= ownerAllowances[tokenOwner][spender]);
        _;
    }

    modifier tokenAmountValid(uint256 amount) {
        require(amount > 0);
        require(amount <= myTotalSupply);
        _;
    }

    /**
     * @dev Retorna o valor nominal.
     */
    function valorNominal() external view returns (uint256) {
        return myTotalSupply;
    }

    /**
     * @dev Retorna o nome do Emissor.
     */
    function nomeEmissor() external view returns (address) {
        return msg.sender;
    }

    /**
     * @dev Retorna a data da emissao.
     */
    function dataEmissao() external view returns (uint256) {
        return _dataEmissao;
    }   

    function alteraFracoes(uint16 fracoes_) external onlyOwner returns (bool) {
        require(fracoes_ >=100, "numero de fracoes baixo");
        _fracoes = fracoes_;
        return true;
    }

    /**
    * @dev retorna o valor da variavel fracoes
    * @notice informa o numero de fracoes da debenture
    */
    function fracoes() external view returns (uint16) {
        return _fracoes;
    }

    /**
     * @dev Emitido quando um novo prazo de pagamento é definido
     */
    event NovoPrazoPagamento(uint256 prazoAntigo, uint256 prazoNovo);


    function name() public view returns(string memory) {
        return myName;
    }

    function symbol() public view returns(string memory) {
        return mySymbol;
    }

    function totalSupply() public override view returns(uint256) {
        return myTotalSupply;
    }



 }