import Foundation

public class Compactador {

	public var dadoCompactado = NSMutableData()
	var byteSaida: UInt8 = 0
	var contadorBit = 0

	public func compactar(dado: String) -> NSData {
		var frequencia = [Int](count: 128, repeatedValue: 0)

		// Contar a frequencia de cada caracter no texto para o vetor de Frequencia.
		for caracter in String(dado).utf8 { 
			frequencia[Int(caracter)] += 1
		}

		// Grava o vetor de Frequencia no dadoCompactado.
		for i in 0...127 {
			var byte = frequencia[i]
			dadoCompactado.appendBytes(&byte, length: 8)
		}

		// Cria a Arvore de acordo com o vetor de Frequencia.
		let arvore = Arvore()
		let raiz = arvore.constroiArvore(frequencia)

		// Para cada caracter do texto, gravar sua nova representação no dadoCompactado.
		for caracter in String(dado).utf8 { 
			procuraFolha(raiz, caracter: UInt8(caracter))
		}

		// Caso o último byte não tenha sido completado, insere 0's.
		escreveResto()

		return dadoCompactado
	}

	/*
	 * Percorre toda a árvore e encontra todos os nós folhas, para cada nó folha, chama
	 * o método escreveBits passando o nó.
	 */
	private func procuraFolha(no: No<Int>, caracter: UInt8){
		if(no.direita == nil && no.esquerda == nil && no.caracter == caracter){
			escreverBits(no, filho: nil)
		} else {
			if no.esquerda != nil {
				procuraFolha(no.esquerda!, caracter: caracter)
			}
			if no.direita != nil {
				procuraFolha(no.direita!, caracter: caracter)	
			}
		}
	}

	/* 
	 * Chama-se a partir de um nó folha o seu pai, consequentemente o pai do pai, até
	 * chegar a raiz. Depois volta escrevendo 0 ou 1, para um arco da esquerda ou da
	 * direita.
	 */
	private func escreverBits(no: No<Int>, filho: No<Int>?){
		if(no.pai != nil){
			escreverBits(no.pai!, filho: no)
		}
		if(filho != nil){
			if(no.direita === filho){
				escreveBit(true)
			} else if no.esquerda === filho {
				escreveBit(false)
			}
		}
	}

	/*
	 * Escreve um novo bit 0 ou 1 no byteSaida. Se o byteSaida estiver completo,
	 * ou seja, com 8 bits, adiciona ao dadoCompactado.
	 */
	private func escreveBit(bit: Bool) {
		if contadorBit == 8 {
			dadoCompactado.appendBytes(&byteSaida, length: 1)
			contadorBit = 0
		}
		bit = bit ? 1 : 0
		byteSaida = (byteSaida << 1) | bit
		contadorBit += 1
	}

	/*
	 * Caso o contadorBit seja maior que 0, ou seja, bits ainda restantes para serem
	 * inseridos no dadoCompactado: Se o byteSaida contem menos de 8 bits, adiciona-se 
	 * 0's a sua direita. Quando completo, é adicionado ao dadoCompactado.
	 */
	private func escreveResto() {
		if contadorBit > 0 {
			if contadorBit < 8 {
				let resto = UInt8(8 - contadorBit)
				byteSaida = byteSaida << resto
			}
			dadoCompactado.appendBytes(&byteSaida, length: 1)
		}
	}
}