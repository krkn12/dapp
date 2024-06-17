// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Incar_DAO {
    string public name = "Incar DAO";
    string public symbol = "INC";
    uint256 public totalSupply = 1e18; // 1 token (18 casas decimais)
    uint256 public maxSupply = 21e12 * 1e18; // 21 trilhões de tokens (18 casas decimais)

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Endereco invalido");
        require(value > 0, "Quantidade invalida");
        require(balanceOf[msg.sender] >= value, "Saldo insuficiente");

        uint256 inflationAmount = (value * 5) / 100000; // Calcula a inflação (0.005%)
        require(totalSupply + inflationAmount <= maxSupply, "Limite de fornecimento excedido");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value + inflationAmount;
        totalSupply += inflationAmount;

        emit Transfer(msg.sender, to, value);
        return true;
    }
}
