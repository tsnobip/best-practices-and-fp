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
  // Get the current user's location
  let currentUserLocation = API.Location.getCurrentLocation()
  
  // Retrieve a list of upcoming events
  let events = API.Event.nextEvents()
  
  events
  // Filter events based on maximum distance and price
  |> List.filter(event => {
       let distance = API.Location.distanceInKm(currentUserLocation, event.location)
       distance <= maxDistanceInKm && event.price <= maxPrice
     })
  // Map each event to a tuple containing the event and its affinity score
  |> List.map(event => {
       // Get the weather forecast for the event
       let weatherForecast = API.Weather.getForecast(event.location, event.startDate)
       // Calculate affinity based on the type of event
       let affinity = switch event.kind {
         | "concert" => API.Affinity.concert(~artists=event.artists, ~venue=event.venue, ~weather=weatherForecast)
         | "movie-screening" => API.Affinity.movie(event)
         | "play" => API.Affinity.play(~playwright=event.playwright, ~director=event.director, ~actors=event.actors)
         | "student-party" => API.Affinity.studentParty(~artists=event.artists, ~venue=event.venue, ~weather=weatherForecast, ~affiliatedUniversity=event.affiliatedUniversitiy)
         | _ => 0.0
       }
       (event, affinity)
     })
  // Filter out events with low affinity scores
  |> List.filter((_, affinity) => affinity > 0.5)
  // Sort events in descending order of affinity
  // however there is always an error with the compiling
  |> List.sort((affinity1, affinity2) => Int.compare(affinity2, affinity1))
  // Return the event with the highest affinity
  |> List.head
