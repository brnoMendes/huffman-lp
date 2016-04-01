import Foundation

public class Descompactador {
	public var dadoDescompactado: String
	var ponteiro: UnsafePointer<UInt8>

	public init(){
		dadoDescompactado = "A"
		let a = NSMutableData()
		a.appendBytes(dadoDescompactado, length:1)
		ponteiro = UnsafePointer<UInt8>(a.bytes)
	}

	public func descompactar(dado: NSData){
		ponteiro = UnsafePointer<UInt8>(dado.bytes)
		
		var frequencia = [UInt8](count: 128, repeatedValue: 0)

		var leitorBit = ManipuladorBit(dado: dado)
		for i in 0...127 {
			frequencia[i] = leByte(leitorBit)
		}

		for i in frequencia {
			
		}
		print()
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