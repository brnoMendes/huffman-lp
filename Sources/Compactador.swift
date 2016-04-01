import Foundation

public class Compactador {

	public var dadoCompactado = NSMutableData()
	var byteSaida: UInt8 = 0
	var contadorBit = 0

	public func compactar(dado: String){
		var frequencia = [Int](count: 128, repeatedValue: 0)

		// Contar a frequencia de cada caracter no texto.
		for character in String(dado).utf8 { 
			frequencia[Int(character)] += 1
		}

		for i in 0...127 {
			var byte = frequencia[i]
			dadoCompactado.appendBytes(&byte, length: 8)
		}

		let arvore = Arvore()
		let raiz = arvore.constroiArvore(frequencia)

		for caracter in String(dado).utf8 { 
			procuraFolha(raiz, caracter: UInt8(caracter))
		}

		escreveResto()
	}

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

	private func escreveBit(bit: Bool) {
		if contadorBit == 8 {
			dadoCompactado.appendBytes(&byteSaida, length: 1)
			contadorBit = 0
		}
		byteSaida = (byteSaida << 1) | (bit ? 1 : 0)
		contadorBit += 1
	}

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