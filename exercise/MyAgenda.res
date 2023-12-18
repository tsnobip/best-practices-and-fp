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

  // let rec filteredEvents = (events) => switch events {
  // |[] => []
  // |[event, rest] when event.price <= maxPrice && distanceInKm(event.location,getCurrentLocation()) <=maxDistanceKm => 
  //  [Event(event.name,event.startDate, event.venu, event.price, event.affinity)].concat(filteredEvents(event.get()))
  // |[event, rest] => filteredEvents(rest)
  // }
  let eventArray = API.Event.nextEvents()
  let result = []
  for i in 0 to Array.length(eventArray) {
    // if (eventArray[i].API.Event.price<=maxPrice && distanceInKm(eventArray[i].location,getCurrentLocation())) {
    //   result.push(eventArray[i])
    // }
    switch eventArray[i] {
      |Some(event) when event.API.Event.price <= maxPrice && API.Location.distanceInKm(event.API.Event.location,API.Location.getCurrentLocation()) <= maxDistanceInKm => Array.push(result, event)
      |_ => ()
    }
  }
  result

  // ignore(maxDistanceInKm)
  // ignore(maxPrice)
  // failwith("TODO")
}
