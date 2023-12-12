module Event = {
  type t = {
    name: string,
    startDate: Date.t,
    venue: string,
    price: float,
    affinity: API.Affinity.t,
  }
}

let oneRecommendationEveryDay = (~maxDistanceInKm, ~maxPrice) => {
  // effacer tout ce qui suit et le remplacer par une implémentation correcte
  // utiliser la fonction API.Event.nextEvents pour récupérer les événements
  // puis les autres fonctions du module API pour obtenir les informations manquantes
  ignore(maxDistanceInKm)
  ignore(maxPrice)
  failwith("TODO")
}
