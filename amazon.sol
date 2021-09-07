//SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.6;

contract security {
    
    modifier onlyShop () {
    require (msg.sender==0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "tu n'as pas le driot");
       _;
       }
}



interface A {
    
    function createArticles(string memory _label, uint _prix) external;
    
}


  contract Amazon is A, security {
    
    uint index;
    address shop =0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    enum EtatProduit {pret, payer, livrer}
    
    struct Article {
    
    uint id;
    string label;
    uint prix;
    EtatProduit etat;
    
    }
    
    mapping (uint => Article) public articles;
    
    
    function createArticles(string memory _label, uint _prix) public  override onlyShop () {

       articles[index]=Article(index, _label, _prix*10**18,EtatProduit.pret); 
       index++;
        
    }
    
    function payment (uint _index) public payable {
        require (articles[_index].etat==EtatProduit.pret, "produit pas encpre pret");
        require (articles[_index].prix==msg.value, "montant insuffisant");
        articles[_index].etat=EtatProduit.payer;
        
        payable(shop).transfer(msg.value);
    }
    
    
        function Livraison (uint _index) public {
        require (articles[_index].etat==EtatProduit.payer, "produit pas encpre pret");
        articles[_index].etat=EtatProduit.livrer;
        
        }

}
