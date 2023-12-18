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


  // Get user current location and date
  let userLocation = API.Location.getCurrentLocation();
  let currentDate = Date.now();
  // Get the list of nexr events
  let events = API.Event.nextEvents();
  // Filter the events based on the max distance and max price
  let filteredEvents = Belt.Array.keep(
    events,
    event => {
      let distance = API.Location.distanceInKm(userLocation, event.location);
      let distanceInRange = distance <= maxDistanceInKm;
      let priceInRange = event.price <= maxPrice;
      distanceInRange && priceInRange;
    },
  );
  // Return the events as intended type
  let returnedEvents = Belt.Array.keep(
    filteredEvents,
    event => {
      // Calculate the affinity depending on the event
      let affinity = switch (event.kind) {
      | "concert" => {
        let artists = switch (event.artists) {
        | Some(artistList) => artistList
        | None => []
        };
        API.Affinity.concert(~artists=artists, ~venue=event.venue, ~weather=API.Weather.getForecast(event.location, event.startDate))
      }
      | "movie-screening" => {
        let movieInfo = API.Movie.getInfo(~title=event.name);
        API.Affinity.movie(movieInfo)
      }
      | "play" => {
        let playInfo = API.Play.getInfo(~title=event.name);
        let director = switch (event.director) {
        | Some(directorList) => directorList
        | None => ""
        };
        let actors = switch (event.actors) {
        | Some(actorList) => actorList
        | None => []
        };
        API.Affinity.play(~playwright=playInfo.playwright, ~director=director, ~actors=actors)
      }
      | "student-party" => {
        let artists = switch (event.artists) {
        | Some(artistList) => artistList
        | None => []
        };
        let affiliatedUniversity = switch (event.affiliatedUniversitiy) {
        | Some(university) => university
        | None => ""
        };
        API.Affinity.studentParty(~artists=artists, ~venue=event.venue, ~weather=API.Weather.getForecast(event.location, event.startDate), ~affiliatedUniversity=affiliatedUniversity)
      }
      | _ => 0.5
      // Sets the event type as desired
      {
        name: event.name,
        startDate: event.startDate,
        venue: event.venue,
        price: event.price,
        affinity: event.affinity,
      }
      }
    }
  )
}
