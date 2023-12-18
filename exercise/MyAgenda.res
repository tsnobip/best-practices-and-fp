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
  // Récupération de la liste des prochains événements.
  let eventArray = API.Event.nextEvents()

  // Initialisation d'un tableau vide pour les résultats filtrés.
  let result = []

  // Itération sur chaque événement pour vérifier s'il correspond aux critères.
  for i in 0 to Array.length(eventArray) {
    // Utilisation d'un pattern matching pour filtrer les événements.
    switch eventArray[i] {
      // Si l'événement est disponible (Some) et correspond aux critères de prix et de distance.
      | Some(event) when event.API.Event.price <= maxPrice &&
                        API.Location.distanceInKm(event.API.Event.location, API.Location.getCurrentLocation()) <= maxDistanceInKm =>
          // Ajout de l'événement au tableau de résultats si les conditions sont remplies.
          Array.push(result, event)
      // Dans les autres cas, ne rien faire.
      | _ => ()
    }
  }
  // Retourner le tableau des événements filtrés.
  result
}
