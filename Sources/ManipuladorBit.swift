import Foundation

public class ManipuladorBit {
	var ponteiro: UnsafePointer<UInt8>
	var byteEntrada: UInt8 = 0
	var contador = 8

	public init(dado: NSData) {
		ponteiro = UnsafePointer<UInt8>(dado.bytes)
	}

	public func leBit() -> Bool {
		if contador == 8 {
			byteEntrada = ponteiro.memory
			contador = 0
			ponteiro = ponteiro.successor()
		}
		let bit = byteEntrada & 0x80
		byteEntrada = byteEntrada << 1
		contador += 1
		return bit == 0 ? false : true
	}	
}