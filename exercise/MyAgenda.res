/* Module 'Event' defines the structure of an event */
module Event = {
  /* Type 't' represents an event with various properties */
  type t = {
    name: string,          /* The name of the event */
    startDate: Date.t,     /* The start date of the event */
    venue: string,         /* The venue where the event will take place */
    price: float,          /* The ticket price for the event */
    affinity: API.Affinity.t, /* An affinity score or rating for the event, based on user preferences */
  }
}

/* Function 'oneRecommendationEveryDay' filters and maps events based on certain conditions */
let oneRecommendationEveryDay = (~maxDistanceInKm, ~maxPrice) => {
  /* Retrieve an array of upcoming events */
  let eventArray = API.Event.nextEvents()

  /* Iterate over 'eventArray', applying a filter and mapping logic */
  let results = Belt.Array.keepMap(eventArray, event => {
    /* Calculate the distance from the current location to the event's location */
    let distance = API.Location.distanceInKm(event.API.Event.location, API.Location.getCurrentLocation())

    /* Determine if the event matches the user's distance and price criteria */
    let affinity = if (distance <= maxDistanceInKm && event.API.Event.price <= maxPrice) {
      /* Switch on the type of event to calculate the affinity differently for each case */
      switch event.API.Event.kind {
      /* Case for a concert event */
      | "concert" => {
          let artists = Js.Option.getWithDefault([], event.API.Event.artists)
          let affinity = API.Affinity.concert(~artists=artists, ~venue=event.API.Event.venue, ~weather=API.Weather.getForecast(event.API.Event.location, event.API.Event.startDate))
          Some(affinity)
        }
      /* Case for a movie screening event */
      | "movie screening" => {
          let affinity = API.Affinity.movie(API.Movie.getInfo(~title=event.API.Event.name))
          Some(affinity)
        }
      /* Case for a play event */
      | "play" => {
          let playInfo = API.Play.getInfo(~title=event.API.Event.name)
          let director = Js.Option.getWithDefault("", event.API.Event.director)
          let actors = Js.Option.getWithDefault([], event.API.Event.actors)
          let affinity = API.Affinity.play(~playwright=playInfo.playwright, ~director=director, ~actors=actors)
          Some(affinity)
        }
      /* Case for a student party event */
      | "student party" => {
          let artists = Js.Option.getWithDefault([], event.API.Event.artists)
          let affiliatedUniversity = Js.Option.getWithDefault("", event.API.Event.affiliatedUniversitiy)
          let affinity = API.Affinity.studentParty(~artists=artists, ~venue=event.API.Event.venue, ~weather=API.Weather.getForecast(event.API.Event.location, event.API.Event.startDate), ~affiliatedUniversity=affiliatedUniversity)
          Some(affinity)
        }
      /* Default case for other types of events */
      | _ => None
      }
    } else {
      None
    }

    /* Map the event to a new structure if an affinity score is available */
    switch affinity {
    | Some(affinity) => Some({Event.name: event.name, startDate: event.startDate, venue: event.venue, price: event.price, affinity: affinity})
    | None => None
    }
  })

  /* Return the final filtered and mapped array of events */
  results
}
