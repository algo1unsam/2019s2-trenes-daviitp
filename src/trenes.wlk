class Deposito {
	
	const property formaciones = []
	const property locomotorasSueltas = []
	
	method vagonesMasPesados() {return formaciones.map({formacion => formacion.vagonesTotales().max({vagon => vagon.peso()} )})}
	method necesitaConductorExperimentado() {return formaciones.any({formacion=>formacion.esCompleja()})}
	
	method cuantoEmpujeFalta(formacion) {return formacion.cuantoEmpujeFalta()}
	
	method agregarLocomotora(formacion) {
		if (self.cuantoEmpujeFalta(formacion) > 0) {
			formacion.locomotoras().add(self.locomotoraConEmpuje(formacion))
		}
		else {
		self.error("")
		}
	}
	
	method locomotoraConEmpuje(formacion) {
		return locomotorasSueltas.filter({locomotora=>locomotora.arrastreUtil() > formacion.cuantoEmpujeFalta()}).first()
	}
}

class Formacion {
	
	const property vagonesDeCarga = []
	const property vagonesDePasajeros = []
	const property locomotoras = []	
	
	method velocidadMaxima() {return locomotoras.min({locomotora=>locomotora.velocidadMaxima()}).velocidadMaxima()}
	
	method vagonesTotales() {return vagonesDeCarga + vagonesDePasajeros}
	
	method vagonesLivianosDeCarga() {return vagonesDeCarga.count({vagon=>vagon.peso() < 2500})}
	method vagonesLivianosDePasajeros() {return vagonesDePasajeros.count({vagon=>vagon.peso() < 2500})}
	
	method vagonesLivianos() {return self.vagonesLivianosDeCarga() + self.vagonesLivianosDePasajeros()}
	
	method esEficiente() {return self.locomotoras().all({locomotora=>locomotora.esEficiente()})}
	
	method pesoMaximoVagonesDeCarga() {return vagonesDeCarga.sum({vagon=>vagon.pesoMaximo()})}
	method pesoMaximoVagonesDePasajeros() {return vagonesDePasajeros.sum({vagon=>vagon.pesoMaximo()})}	
	
	method pesoMaximoVagones() {return self.pesoMaximoVagonesDeCarga() + self.pesoMaximoVagonesDePasajeros()}
	
	method arrastreUtilTotal() {return self.locomotoras().sum({locomotora=>locomotora.arrastreUtil()})}
	
	method puedeMoverse() {return self.arrastreUtilTotal() >= self.pesoMaximoVagones()}
	
	method cuantoEmpujeFalta() {if (self.puedeMoverse()) return 0 else return (self.pesoMaximoVagones() - self.arrastreUtilTotal())}
	
	method cantidadLocomotoras() {return self.locomotoras().size()}
	method cantidadVagonesCarga() {return self.vagonesDeCarga().size()}
	method cantidadVagonesPasajeros() {return self.vagonesDePasajeros().size()}
	
	method cantidadUnidades() {return self.cantidadLocomotoras() + self.cantidadVagonesCarga() + self.cantidadVagonesPasajeros()}
	
	method pesoVagonesDeCarga() {return self.vagonesDeCarga().sum({vagon=>vagon.peso()})}
	method pesoVagonesDePasajeros() {return self.vagonesDePasajeros().sum({vagon=>vagon.peso()})}
	method pesoLocomotoras() {return self.locomotoras().sum({vagon=>vagon.peso()})}
	
	method pesoTotal() {return self.pesoVagonesDeCarga() + self.pesoVagonesDePasajeros() + self.pesoLocomotoras()}
	
	method esCompleja() {return (self.cantidadUnidades() > 20 or self.pesoTotal() > 10000 )}
	
	method bienArmadaCortaDistancia() {return self.puedeMoverse() and (not(self.esCompleja()))}
	method bienArmadaLargaDistancia() {return self.puedeMoverse() and self.alcanzanLosBanios()}
	
	method pasajerosTransportados() {return vagonesDePasajeros.sum({vagon=>vagon.pasajerosTransportados()})}
	method cuantosBaniosHay() {return vagonesDePasajeros.sum({vagon=>vagon.banios()})}
	
	method alcanzanLosBanios() {return ((self.pasajerosTransportados() / self.cuantosBaniosHay()) <= 50 )}
}

class VagonDePasajeros {
	
	var property largo
	var property ancho
	var property pasajerosTransportados
	var property banios
	
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
