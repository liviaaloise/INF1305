pragma solidity >=0.5.2;

contract GuardaReserva{
	address dono;
	bool[] reservas;
	address[] hospedes;

	//fazer alguma coisa só pra quem é dono do contrado

	//reserva de casa de temporada
	// dono de alguma coisa que aluga
	
	
	constructor(uint numeroDias) public {
	    dono = msg.sender;
	    
		for(uint i=0; i<numeroDias; i++){
		    reservas.push(true);
			hospedes.push(dono);
		}
	}

	function fazerReserva(uint dia) public{
		require(reservas[dia], "Dia nao disponível para reserva");
		reservas[dia] = false;
		hospedes[dia] = msg.sender;
	}

	event donoCancelou(address hospede);

	function cancelarReserva(uint dia) public{
		require(msg.sender == hospedes[dia]|| msg.sender == dono,"Nao e o dono da reserva");
		if(msg.sender == dono){
			emit donoCancelou(hospedes[dia]);
		}
		reservas[dia] = true;
		hospedes[dia] = dono;
	}

	function verDisponibiblidade (uint dia) public view returns (bool){
	    return reservas[dia];
	}
	
	function verReservas () public view returns (bool[] memory){
	    require(msg.sender == dono,"Somente o dono pode ver reservas");
	    return reservas;
	}
}












