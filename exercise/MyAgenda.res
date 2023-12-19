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

  let results = Belt.Array.keepMap(eventArray, event => {
    let distance = API.Location.distanceInKm(event.API.Event.location, API.Location.getCurrentLocation())

    let affinity = if (distance <= maxDistanceInKm && event.API.Event.price <= maxPrice) {
      switch event.API.Event.kind {
      | "concert" => {
          let artists = Js.Option.getWithDefault([], event.API.Event.artists)
          let affinity = API.Affinity.concert(~artists=artists, ~venue=event.API.Event.venue, ~weather=API.Weather.getForecast(event.API.Event.location, event.API.Event.startDate))
          Some(affinity)
        }
      | "movie screening" => {
          let affinity = API.Affinity.movie(API.Movie.getInfo(~title=event.API.Event.name))
          Some(affinity)
        }
      | "play" => {
          let playInfo = API.Play.getInfo(~title=event.API.Event.name)
          let director = Js.Option.getWithDefault("", event.API.Event.director)
          let actors = Js.Option.getWithDefault([], event.API.Event.actors)
          let affinity = API.Affinity.play(~playwright=playInfo.playwright, ~director=director, ~actors=actors)
          Some(affinity)
        }
      | "student party" => {
          let artists = Js.Option.getWithDefault([], event.API.Event.artists)
          let affiliatedUniversity = Js.Option.getWithDefault("", event.API.Event.affiliatedUniversitiy)
          let affinity = API.Affinity.studentParty(~artists=artists, ~venue=event.API.Event.venue, ~weather=API.Weather.getForecast(event.API.Event.location, event.API.Event.startDate), ~affiliatedUniversity=affiliatedUniversity)
          Some(affinity)
        }
      | _ => None
      }
    } else {
      None
    }
    switch affinity {
    | Some(affinity)  => Some({Event.name: event.name,   startDate: event.startDate,  venue: event.venue,  price: event.price,affinity: affinity})
    | None => None
    }

  })

  results
}
