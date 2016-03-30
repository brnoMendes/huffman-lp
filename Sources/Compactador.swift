import Foundation

public class Compactador {

	public var dado = NSMutableData()

	public func compactar(dado: String){
		var frequencia = [Int](count: 128, repeatedValue: 0)

		// Contar a frequencia de cada caracter no texto.
		for character in String(dado).utf8 { 
			frequencia[Int(character)] += 1
		}

		var arvore = [No<Int>()]
		arvore.removeLast()

		// Criar uma Arvore para cada Caracter.
		for i in 0...127 {
			if(frequencia[i] > 0) {
				let no = No<Int>()
				no.inserir(frequencia[i], caracter: i)
				arvore.append(no)
			}
		}

		// Construir a Arvore
		while arvore.count > 1 {
			ordena(&arvore)
			let novoNo = No<Int>()
			let no1 = arvore.removeFirst()
			let no2 = arvore.removeFirst()
			novoNo.peso = no1.peso! + no2.peso!
			no1.pai = novoNo
			no2.pai = novoNo
			novoNo.inserir(no1, direita: no2)
			arvore.append(novoNo)
		}

		let raiz = arvore.removeFirst()

		for caracter in String(dado).utf8 { 
			procuraFolha(raiz, caracter: Int(caracter))
		}

		escreveResto()
	}

	private func ordena(inout vetor: [No<Int>]) {
		
		let tam = vetor.count - 1
		
		for i in 0...tam {
			let atual = vetor[i]
			var j = i-1
			while (j >= 0 && atual.peso < vetor[j].peso) {
				vetor[j+1] = vetor[j]
	            j = j-1
			}	    
			vetor[j+1] = atual
		}
	}

	private func procuraFolha(no: No<Int>, caracter: Int){
		if(no.direita == nil && no.esquerda == nil && no.caracter == caracter){
			escrever(no, filho: nil)
		} else {
			if no.esquerda != nil {
				procuraFolha(no.esquerda!, caracter: caracter)
			}
			if no.direita != nil {
				procuraFolha(no.direita!, caracter: caracter)	
			}
		}
	}

	private func escrever(no: No<Int>, filho: No<Int>?){
		if(no.pai != nil){
			escrever(no.pai!, filho: no)
		}
		if(filho != nil){
			if(no.direita === filho){
				escreveBit(true)
			} else if no.esquerda === filho {
				escreveBit(false)
			}
		}
	}

	var byteSaida: UInt8 = 0
	var contadorBit = 0

	private func escreveBit(bit: Bool) {
		if contadorBit == 8 {
			dado.appendBytes(&byteSaida, length: 1)
			contadorBit = 0
		}
		byteSaida = (byteSaida << 1) | (bit ? 1 : 0)
		contadorBit += 1
	}

	private func escreveResto() {
		if contadorBit > 0 {
			if contadorBit < 8 {
				let resto = UInt8(8 - contadorBit)
				byteSaida <<= resto
			}
			dado.appendBytes(&byteSaida, length: 1)
		}
	}
}