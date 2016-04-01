import Foundation

public class Descompactador {

	public func descompactar(dado: NSData) -> String {
		
		var frequencia = [Int](count: 128, repeatedValue: 0)

		let leitorBit = ManipuladorBit(dado: dado)
		for i in 0...127 {
			frequencia[i] = leInt(leitorBit)
		}

		let arvore = Arvore()
		let raiz = arvore.constroiArvore(frequencia)

		let quantidadeCaracteres = raiz.peso!

		var string: String = ""
		for _ in 0...(quantidadeCaracteres - 1){
			var caracter = raiz;
			while caracter.direita != nil && caracter.esquerda != nil {
				if leitorBit.leBit() {
					caracter = caracter.direita!
				} else {
					caracter = caracter.esquerda!
				}
			}
			string.append(UnicodeScalar(caracter.caracter!))
		}
		return string
	}

	private func leInt(leitorBit: ManipuladorBit) -> Int {
		var int = 0
		var shift = 0;
		for _ in 0...7 {
			var byte: UInt8 = 0
			var mascara: UInt8 = 0x80
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