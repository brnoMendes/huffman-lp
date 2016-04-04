import Foundation

public class Descompactador {

	public func descompactar(dado: NSData) -> String {
		
		var frequencia = [Int](count: 128, repeatedValue: 0)

		// Cria um ManipuladorBit para o dado compactado. E Lê o vetor de frequencia.
		let leitorBit = ManipuladorBit(dado: dado)
		for i in 0...127 {
			frequencia[i] = leInt(leitorBit)
		}

		// Remonta a árvore com o vetor de frequencia lido.
		let arvore = Arvore()
		let raiz = arvore.constroiArvore(frequencia)

		let quantidadeCaracteres = raiz.peso!

		// Remontar o texto na váriavel string, a partir da arvore remontada e da leitura
		// de bits do arquivo compactado.
		// For de 0 até quantidade de caracteres presente no texto original.
		var string: String = ""
		for _ in 0...(quantidadeCaracteres - 1){
			var caracter = raiz;

			// Percorre a árvore a partir da raiz, com 1 para direita e 0 para esquerda,
			// até encontrar um nó folha.
			while caracter.direita != nil && caracter.esquerda != nil {
				if leitorBit.leBit() {
					caracter = caracter.direita!
				} else {
					caracter = caracter.esquerda!
				}
			}

			// Adiciona o caracter do nó folha encontrado na string.
			string.append(UnicodeScalar(caracter.caracter!))
		}

		return string
	}

	/*
	 * Lê o proximo Int no dadoCompactado. 
	 */
	private func leInt(leitorBit: ManipuladorBit) -> Int {
		var int = 0
		var shift = 0;
		// For de 0 a 7, ou seja, lê 8 bytes para o Int.
		for _ in 0...7 {
			var byte: UInt8 = 0
			var mascara: UInt8 = 0x80

			// For de 0 a 7, 8 bits para um byte.
			for _ in 0...7 {
				if leitorBit.leBit() {
					byte = byte | mascara
				}
				mascara = mascara >> 1
			}

			int = int | (Int(byte) << shift)
			shift += 8
		}
		return int
	}
}