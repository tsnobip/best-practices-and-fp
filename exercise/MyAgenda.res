module Event = {
  type t = {
    name: string,
    startDate: Date.t,
    venue: string,
    price: float,
  }
}

let oneRecommendationEveryDay = (~maxDistanceInKm, ~maxPrice) => {
  // effacer tout cela et le remplacer par une implémentation correcte
  ignore(maxDistanceInKm)
  ignore(maxPrice)
  failwith("TODO")
}
