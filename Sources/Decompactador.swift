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
		let cabecalho = getCabecalho(dado)
		print(cabecalho.length)
		let arvore = getArvore(cabecalho)

		arvore!.imprimir()
	}

	private func getCabecalho(dado: NSData) -> NSData {
		let cabecalho = NSMutableData()
		var byte: UInt8 = 1
		while byte != 0 {
			byte = ponteiro.memory
			if(byte != 0){
				cabecalho.appendBytes(&byte, length: 1)
				ponteiro = ponteiro.successor()
			} 
		}
		return cabecalho
	}

	private func getArvore(cabecalho: NSData) -> No<Int>? {
		let leitor = Leitor(dado: cabecalho)
		if leitor.leBit()! {
			let raiz = No<Int>()
			raiz.peso = 1
			raiz.direita = nil
			raiz.esquerda = nil
			recriaArvore(leitor, no: raiz)
			return raiz
		} else {
			return nil
		}
	}

	private func recriaArvore(leitor: Leitor, no: No<Int>){
		//print("Esquerda:", terminator: ":")
		let esquerda = leitor.leBit()
		if esquerda != nil {
			if esquerda! {
				let noFilho = No<Int>()
				noFilho.peso = 1
				noFilho.direita = nil
				noFilho.esquerda = nil
				no.esquerda = noFilho
				recriaArvore(leitor, no: noFilho)  
			} else {
				let noFilho = No<Int>()
				let caracter = leitor.leByte()
				if caracter == nil {
					return
				}
				noFilho.caracter = caracter
				noFilho.peso = 2
				noFilho.direita = nil
				noFilho.esquerda = nil
				no.esquerda = noFilho
			}
		}
		//print("Direita:", terminator: ":")
		let direita = leitor.leBit()
		if direita != nil {
			if direita! {
				let noFilho = No<Int>()
				noFilho.peso = 1
				noFilho.direita = nil
				noFilho.esquerda = nil
				no.direita = noFilho
				recriaArvore(leitor, no: noFilho)
			} else {
				let noFilho = No<Int>()
				let caracter = leitor.leByte()
				noFilho.caracter = caracter
				noFilho.peso = 2
				noFilho.direita = nil
				noFilho.esquerda = nil
				no.direita = noFilho		
			}
		}
	}
}

public class Leitor {
	var ponteiro: UnsafePointer<UInt8>
	var byteEntrada: UInt8 = 0
	var contador = 8
	var quantidadeBytes = 0
	var tamanhoCabecalho: Int

	public init(dado: NSData) {
		tamanhoCabecalho = dado.length
		ponteiro = UnsafePointer<UInt8>(dado.bytes)
	}

	public func leBit() -> Bool? {
		if contador == 8 {
			quantidadeBytes += 1
			if quantidadeBytes >= tamanhoCabecalho{
				return nil
			}
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

	public func leByte() -> UInt8? {
		var byte = UInt8(0)
		var mascara = UInt8(0x40)
		//print("Byte:", terminator: "")
		for _ in 0...6 {
			if contador == 8 {
				byteEntrada = ponteiro.memory
				contador = 0
				ponteiro = ponteiro.successor()
				quantidadeBytes += 1
				if quantidadeBytes >= tamanhoCabecalho{
					return nil
				}
			}
			let bit = byteEntrada & 0x80
			if(bit != 0){
				print("1", terminator: " ")
				byte = byte | mascara
			} else {
				print("0", terminator: " ")
			}
			mascara = mascara >> 1
			byteEntrada = byteEntrada << 1
			contador += 1
		}
		return byte
	}
}