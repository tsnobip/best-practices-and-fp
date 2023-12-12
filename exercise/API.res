// INTERNAL
// DO NOT MODIFY THIS FILE

module Location = {
  type t = {
    latitude: float,
    longitude: float,
  }

  let distanceInKm = ({latitude: lat1, longitude: lon1}, {latitude: lat2, longitude: lon2}) => {
    let toRadians = angle => angle *. Math.Constants.pi /. 180.0
    let lon1 = toRadians(lon1)
    let lon2 = toRadians(lon2)
    let lat1 = toRadians(lat1)
    let lat2 = toRadians(lat2)

    // Haversine formula
    let dlon = lon2 -. lon1
    let dlat = lat2 -. lat1
    let a =
      Math.pow(Math.sin(dlat /. 2.0), ~exp=2.0) +.
      Math.cos(lat1) *. Math.cos(lat2) *. Math.pow(Math.sin(dlon /. 2.0), ~exp=2.0)

    let c = 2.0 *. Math.asin(Math.sqrt(a))

    // Radius of earth in kilometers.
    let r = 6371.0

    // calculate the result
    c *. r
  }

  let getCurrentLocation = () => {latitude: 45.417303336312735, longitude: 4.413601653972717}
}

module Movie = {
  module Actor = {
    type t = {name: string}
  }
  module Director = {
    type t = {name: string}
  }

  type t = {
    title: string,
    director: Director.t,
    actors: array<Actor.t>,
  }

  let getInfo = (~title) => {
    title,
    director: {name: "Jérémie Périn"},
    actors: [{name: "Léa Drucker"}, {name: "Daniel Njo Lobé"}],
  }
}

module Play = {
  module Playwright = {
    type t = {name: string}
  }

  type t = {
    title: string,
    playwright: Playwright.t,
  }

  let getInfo = (~title) => {
    title,
    playwright: {name: "Eugène Ionesco"},
  }
}

module Weather = {
  type condition = Clear | Cloudy | Snowy | Rainy | Windy
  type t = {
    temperature: float,
    condition: condition,
  }

  let getForecast = (_location, date) =>
    switch date->Date.toISOString->String.slice(~start=0, ~end=10) {
    | "2024-12-12" => {temperature: 14.0, condition: Rainy}
    | "2024-12-13" => {temperature: 10.0, condition: Windy}
    | "2024-12-14" => {temperature: 6.0, condition: Snowy}
    | "2024-12-15" => {temperature: 6.0, condition: Cloudy}
    | "2024-12-16" => {temperature: 5.0, condition: Clear}
    | _ => {temperature: 8.0, condition: Rainy}
    }
}

module Affinity = {
  type t = float
  let toString = affinity => `${(affinity *. 100.0)->Float.toFixed}%`
  let concert = (~artists, ~venue, ~weather) => {
    switch (venue, weather.Weather.condition, artists) {
    | ("Les guinguettes de Couriot", Windy | Rainy | Snowy, _) => 0.2
    | (_, _, ["Laurent Garnier"]) => 0.92
    | (_, _, ["Tame Impala", "Moodoïd"]) => 0.88
    | (_, _, ["The Weeknd", "Sabrina Claudio"]) => 0.85
    | _ => 0.5
    }
  }

  let movie = _movie => 0.83

  let play = (~playwright as _, ~director as _, ~actors as _) => 0.78

  let studentParty = (~artists as _, ~venue as _, ~weather as _, ~affiliatedUniversity as _) => 0.77
}

module Event = {
  type t = {
    id: int,
    name: string,
    kind: string,
    startDate: Date.t,
    price: float,
    venue: string,
    location: Location.t,
    artists?: array<string>,
    actors?: array<string>,
    director?: string,
    affiliatedUniversitiy?: string,
  }

  let nextEvents = () => [
    {
      id: 11,
      name: "Tame Impala, Live in Saint-Etienne",
      kind: "concert",
      venue: "Zenith",
      location: {latitude: 45.45445689999999, longitude: 4.392837776712139},
      startDate: Date.fromString("2024-12-12T19:00:00.000Z"),
      artists: ["Tame Impala", "Moodoïd"],
      price: 35.0,
    },
    {
      id: 12,
      name: "The Weeknd @ Les guinguettes de Couriot",
      kind: "concert",
      venue: "Les guinguettes de Couriot",
      location: {latitude: 45.43890888024989, longitude: 4.377059586541549},
      startDate: Date.fromString("2024-12-13T18:30:00.000Z"),
      artists: ["The Weeknd", "Sabrina Claudio"],
      price: 40.0,
    },
    {
      id: 21,
      name: "Mars Express",
      kind: "movie-screening",
      venue: "Cinéma le Méliès",
      location: {latitude: 45.44124400105819, longitude: 4.388264709511694},
      startDate: Date.fromString("2024-12-13T20:45:00.000Z"),
      price: 7.5,
    },
    {
      id: 22,
      name: "La Cantatrice chauve",
      venue: "La Comédie de Saint-Étienne",
      kind: "play",
      location: {latitude: 45.452199976743955, longitude: 4.3918787619774005},
      startDate: Date.fromString("2024-12-13T19:00:00.000Z"),
      price: 15.0,
    },
    {
      id: 31,
      name: "La nuit des architectes",
      venue: "École nationale supérieure d'architecture de Saint-Etienne",
      kind: "student-party",
      location: {latitude: 45.441678898863394, longitude: 4.3815702613697125},
      startDate: Date.fromString("2024-12-14T18:45:00.000Z"),
      affiliatedUniversitiy: "École nationale supérieure d'architecture de Saint-Etienne",
      price: 5.0,
    },
    {
      id: 32,
      name: "Laurent Garnier au Sucre",
      venue: "Le Sucre",
      kind: "concert",
      location: {latitude: 45.737381128398894, longitude: 4.814962038622825},
      startDate: Date.fromString("2024-12-14T22:30:00.000Z"),
      price: 15.0,
      artists: ["Laurent Garnier"],
    },
  ]
}
