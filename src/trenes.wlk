object deposito {
	
	const property formaciones = []
	
	method vagonMasPesado() {
		return formaciones.filter({formacion=>formacion.vagonMasPesado()})
	}
}

class Formacion {
	
	const property vagonesDeCarga = []
	const property vagonesDePasajeros = []
	const property locomotoras = []	
	
	method velocidadMaxima() {return locomotoras.min({locomotora=>locomotora.velocidadMaxima()}).velocidadMaxima()}
	
	method vagonMasPesadoDeCarga() {return vagonesDeCarga.max({vagon=>vagon.peso()})}
	method vagonMasPesadoDePasajeros() {return vagonesDeCarga.max({vagon=>vagon.peso()})}
	
	method vagonMasPesado() {}

	method vagonesLivianosDeCarga() {return vagonesDeCarga.count({vagon=>vagon.peso() < 2500})}
	method vagonesLivianosDePasajeros() {return vagonesDePasajeros.count({vagon=>vagon.peso() < 2500})}
	
	method vagonesLivianos() {return self.vagonesLivianosDeCarga() + self.vagonesLivianosDePasajeros()}
	
	method esEficiente() {return locomotoras.all({locomotora=>locomotora.esEficiente()})}
	
	method pesoMaximoVagonesDeCarga() {return vagonesDeCarga.sum({vagon=>vagon.pesoMaximo()})}
	method pesoMaximoVagonesDePasajeros() {return vagonesDePasajeros.sum({vagon=>vagon.pesoMaximo()})}	
	
	method pesoMaximoVagones() {return self.pesoMaximoVagonesDeCarga() + self.pesoMaximoVagonesDePasajeros()}
	
	method arrastreUtilTotal() {return locomotoras.sum({locomotora=>locomotora.arrastreUtil()})}
	
	method puedeMoverse() {return self.arrastreUtilTotal() >= self.pesoMaximoVagones()}
	
	method cuantoEmpujeFalta() {if (self.puedeMoverse()) return 0 else return (self.pesoMaximoVagones() - self.arrastreUtilTotal())}
	
	method cantidadLocomotoras() {return locomotoras.lenght()}
	method cantidadVagonesCarga() {return vagonesDeCarga.lenght()}
	method cantidadVagonesPasajeros() {return vagonesDePasajeros.lenght()}
	
	method cantidadUnidades() {return self.cantidadLocomotoras() + self.cantidadVagonesCarga() + self.cantidadVagonesPasajeros()}

}

class VagonDePasajeros {
	
	var property largo
	var property ancho
	var property pasajerosTransportados
	
	method pasajerosQuePuedeTransportar() {if (ancho <= 2.5) return largo * 8 else return largo * 10}
		
	method pesoMaximo() {return self.pasajerosQuePuedeTransportar() * 80}
	
	method peso() {return pasajerosTransportados * 80}
	
	method soyLiviano() {return self.peso() < 2500}
	
}

class VagonDeCarga {
	
	var property cargaMaxima
	var property cargaTransportada
	
	method pesoMaximo() {return (cargaMaxima + 160)}
	
	method peso() {return cargaTransportada + 160}
	
	method soyLiviano() {return self.peso() < 2500}
}

class Locomotora{
	
	var property peso
	var property pesoMaximoQueArrastra
	var property velocidadMaxima
	
	method arrastreUtil() {return pesoMaximoQueArrastra - peso}
	method esEficiente() {return pesoMaximoQueArrastra >= (peso*5)}
	
}
