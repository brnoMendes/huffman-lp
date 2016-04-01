public class No<Int: Comparable> {

	var peso: Int?
	var caracter: UInt8?
	var pai: No?
	var esquerda: No?
	var direita: No?

	func inserir(esquerda: No?, direita: No?){
		if(esquerda != nil){
			self.esquerda = esquerda
		}
		if(direita != nil){
			self.direita = direita
		}
	}

	func inserir(peso: Int, caracter: UInt8){
		self.peso = peso
		self.caracter = caracter
		self.pai = nil
		self.esquerda = nil
		self.direita = nil
	}

	func imprimir(){
		print("Valor:", self.peso)
		if(self.esquerda != nil){
			self.esquerda!.imprimir()
		}
		if(self.direita != nil){
			self.direita!.imprimir()
		}
	}
}