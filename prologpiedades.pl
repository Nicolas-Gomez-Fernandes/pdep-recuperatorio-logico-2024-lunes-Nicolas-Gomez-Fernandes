% PUNTO 1
vive(juan, casa(120)).
vive(nico, departamento(3, 2)).
vive(alf, departamento(2, 1)).
vive(julian, loft(200)).
vive(vale, departamento(4, 1)).
vive(fer, casa(110)).

zona(alf, almagro).
zona(juan, almagro).
zona(nico, almagro).
zona(juli, almagro).
zona(vale, flores).
zona(fer, flores).


esBarrioCopado(Barrio):-
    zona(_, Barrio),
    forall(zona(Persona, Barrio), viveEnPropiedad(Persona, copada)).

viveEnPropiedad(Persona, TipoDePropiedad) :-
    vive(Persona, Propiedad),
    clasificacionDePropiedad(Propiedad, TipoDePropiedad).

clasificacionDePropiedad(Propiedad, copada) :-
    esPropiedadCopada(Propiedad).

clasificacionDePropiedad(Propiedad, barata) :-
    esBarataUnaPropiedad(Propiedad).

esPropiedadCopada(casa(MetrosCuadrados)) :-
    MetrosCuadrados > 100.

esPropiedadCopada(departamento(CantidadDeAmbientes, _)) :-
    CantidadDeAmbientes > 3.

esPropiedadCopada(departamento(_, CantidadDeBanios)) :-
    CantidadDeBanios > 1.

esPropiedadCopada(loft(AnioDeConstruccion)) :-
    AnioDeConstruccion > 2015.


%  PUNTO 3
esBarrioCaro(Barrio) :-
    zona(_, Barrio),
    forall(zona(Persona, Barrio), not(viveEnPropiedad(Persona, barata))).

esBarataUnaPropiedad(loft(AnioDeConstruccion)) :-
    AnioDeConstruccion < 2005.

esBarataUnaPropiedad(casa(MetrosCuadrados)) :-
    MetrosCuadrados < 90.

esBarataUnaPropiedad(departamento(1, _)).
esBarataUnaPropiedad(departamento(2, _)).


% PUNTO 4
tasacion(juan, casa(120), 150000).
tasacion(nico, departamento(3, 2), 80000).
tasacion(alf, departamento(2, 1), 75000).
tasacion(julian, loft(200), 140000).
tasacion(vale, departamento(4, 1), 95000).
tasacion(fer, casa(110), 60000).


podemosComprarCasas(MontoInicial, MontoFinal, CasasCompradas) :-
    casaTasada(Casa, _),
    listaDeCasas(Casas),
    findall(Casa, cadenaDeCasas(MontoInicial, MontoFinal, Casas), CasasCompradas).
    

podemosComprar(Casa, MontoInicial, MontoFinal) :-
    tasacion(_, Casa, Precio), 
    MontoInicial > Precio, 
    MontoFinal is MontoInicial - Precio,
    MontoFinal > 0.

cadenaDeCasas(MontoInicial, MontoFinal, [Casa1 | CasasSiguientes]):-
        podemosComprar(Casa1, MontoInicial, MontoFinal),
        cadenaDeCasas([CasasSiguientes]).
cadenaDeCasas([]).

listaDeCasas(Casas) :-
    findall(Casa, casaTasada(Casa, _), Casas).

casaTasada(Casa, Persona) :-
    vive(Persona, Casa),
    tasacion(Persona, Casa, _).
