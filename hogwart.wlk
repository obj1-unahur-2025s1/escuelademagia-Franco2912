class Criatura {
  var salud

  method bajaSalud(unaCantidad){
    salud -= unaCantidad
  }
  method subeSalud(unaCantidad){
    salud += unaCantidad
  }
}

class CriaturaPractica inherits Criatura {
  override method bajaSalud(unaCantidad){}
  override method subeSalud(unaCantidad){}
} 

class Estudiante {
  var salud
  var casa
  var property habilidad
  const property hechizos = #{}
  const sangrePura

  method esSangrePura() = sangrePura
  method sonPeligrosos() = salud >= 0 and casa.sonPeligrosos(self)
  method aprenderHechizo(unHechizo){hechizos.add(unHechizo)}
  
  method bajaSalud(unaCantidad){
    salud -= unaCantidad
  }
  method subeSalud(unaCantidad){
    salud += unaCantidad
  }

  method aumentarHabilidad(){
    habilidad += 1
  }
  method disminuirHabilidad(){
    habilidad -= 1
  }

  method cambiarCasa(unaCasa){
    casa = unaCasa
  }

  method cumpleLaCondicion(unHechizo) = unHechizo.condicion(self)
  method usarHechizo(unHechizo, alquien){
    if(self.hechizos().contains(unHechizo) and self.cumpleLaCondicion(unHechizo)){
      unHechizo.lanzarHechizoA(self, alquien)
      }
    }

}

object gryffindor {
  method esPeligroso(estudiante) = false
}

object slytherin {
  method esPeligroso(estudiante) = true
}

object ravenclaw {
  method esPeligroso(estudiante) = estudiante.habilidad() > 10
}

object hufflepuff {
  method esPeligroso(estudiante) = estudiante.esSangrePura()
}


class Materia {
  const inscripciones = #{}
  var hechizo

  method inscribir(unAlumno){
    inscripciones.add(unAlumno)
  }
  method desinscribir(unAlumno){
    inscripciones.remove(unAlumno)
  }

  method cambiarHechizo(unHechizo){
    hechizo = unHechizo
  }

  method dictarMateria() = inscripciones.forEach({a => a.aumentarHabilidad() and a.aprenderHechizo(hechizo)}) 
  method alguienAprendioElHechizo() = inscripciones.any({a => a.hechizos().contains(hechizo)})

  method listarQuinesAprendieronElHechizo() = inscripciones.filter({a => a.hechizos().contains(hechizo)})

  method practicarHechizoEn(unaCriatura) = inscripciones.forEach({a => a.usarHechizo(hechizo, unaCriatura)})
}


object inmobilus {
  method condicion(unAlumno) = unAlumno.habilidad() > 5

  method lanzarHechizoA(alumno, cualquiera) {
    cualquiera.bajaSalud(10)
    alumno.bajaSalud(0)
  }
  method esImperdonable() = false
}

object sectumSempra {
  method condicion(unAlumno) = unAlumno.esPeligroso()

  method lanzarHechizoA(alumno, cualquiera) {
    cualquiera.bajaSalud(10)
    alumno.disminuirHabilidad()
  }

  method esImperdonable() = false
}

object hechizoImperdonable {

  method lanzarHechizoA(alumno, cualquiera) {
    cualquiera.bajaSalud(20)
    alumno.bajaSalud(20)
  }
  method esImperdonable() = true
}

object amorPorongus {
  method condicion(unAlumno) = unAlumno.esSangrePura()

  method lanzarHechizoA(alumno, cualquiera) {
    cualquiera.subeSalud(10)
    alumno.cambiarCasa(hufflepuff)
  }

  method esImperdonable() = false
}

