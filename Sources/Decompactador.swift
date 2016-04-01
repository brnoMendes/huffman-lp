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
		//let cabecalho = getCabecalho(dado)
		//let arvore = getArvore(cabecalho)

		//arvore!.imprimir()
	}

	//private func getCabecalho(dado: NSData) -> NSData {
	//}

	//private func getArvore(cabecalho: NSData) -> No<Int>? {
	//}

	//private func recriaArvore(leitor: Leitor, no: No<Int>){
	//}
}

public class Leitor {
	var ponteiro: UnsafePointer<UInt8>
	var byteEntrada: UInt8 = 0
	var contador = 8

	public init(dado: NSData) {
		ponteiro = UnsafePointer<UInt8>(dado.bytes)
	}

	public func leBit() -> Bool? {
		if contador == 8 {
			byteEntrada = ponteiro.memory
			contador = 0
			ponteiro = ponteiro.successor()
		}
		let bit = byteEntrada & 0x80
		byteEntrada = byteEntrada << 1
		contador += 1
		//print("A:", terminator: "")
		bit == 0 ? print("0", terminator: " ") : print("1", terminator: " ")
		return bit == 0 ? false : true
	}

	
}