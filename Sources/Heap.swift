public class Heap{

	public struct No{
		var peso: Int
		var caracter: Int
		var esquerda: Int
		var direita: Int
	}

	var raiz: Int = -1
	var vetor = [No]()

	public init(){

	}

	public func inserir(peso: Int, caracter: Int){

	}

	private func indicePai(indice: Int) -> Int{
		return indice/2
	}

	private func indiceDireita(indice: Int) -> Int{
		return indice * 2
	}

	private func indiceEsquerda(indice: Int) -> Int{
		return (indice * 2) + 1
	}
}