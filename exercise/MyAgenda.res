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
  let eventArray = API.Event.nextEvents()
  let result = []
  for i in 0 to Array.length(eventArray) {
    switch eventArray[i] {
      |Some(event) when event.API.Event.price <= maxPrice && API.Location.distanceInKm(event.API.Event.location,API.Location.getCurrentLocation()) <= maxDistanceInKm => Array.push(result, event)
      |_ => ()
    }
  }
  result
}
