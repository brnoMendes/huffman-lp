import Foundation

public class Descompactador {

	public func descompactar(dado: NSData) -> String {
		
		var frequencia = [UInt8](count: 128, repeatedValue: 0)

		var leitorBit = ManipuladorBit(dado: dado)
		for i in 0...127 {
			frequencia[i] = leByte(leitorBit)
		}

		var arvore = Arvore()
		var raiz = arvore.constroiArvore(frequencia)

		var quantidadeCaracteres = raiz.peso!

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

	private func leByte(leitorBit: ManipuladorBit) -> UInt8 {
		var byte: UInt8 = 0

		var mascara: UInt8 = 0x80
		for _ in 0...7 {
			if leitorBit.leBit() {
				byte = byte | mascara
			}
			mascara = mascara >> 1
		}

		return byte
	}
}