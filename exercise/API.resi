module Location: {
  type t
  /**
    * returns the distance between two locations in kilometers
   */
  let distanceInKm: (t, t) => float

  /**
    * returns the user's current location
   */
  let getCurrentLocation: unit => t
}

module Event: {
  /**
    * an event as stored in our dummy database
   */
  type t = {
    /**
      * a unique identifier for the event
     */
    id: int,
    /**
      * the name of the event
     */
    name: string,
    /** 
      *can be "movie screening", "concert", "play", 
      * or "student party"
     */
    kind: string,
    /**
      * the date and time the event starts
     */
    startDate: Date.t,
    /**
      * price of the event in euros
     */
    price: float,
    /**
      * the name of the location where the event takes place
     */
    venue: string,
    /**
      * the geographic coordinates where the event takes place
     */
    location: Location.t,
    /**
      * the names of the musicians, bands and/or DJs of the event
      * (for concerts only)
     */
    artists?: array<string>,
    /**
      * the actors of the event
      * (for plays only)
     */
    actors?: array<string>,
    /**
      * the director of the play
      * (for plays only)
     */
    director?: string,
    /**
      * the names of the universities that organize the event
      * (for student parties only)
     */
    affiliatedUniversitiy?: string,
  }

  /**
    * returns the events that'll take place in the next few days
   */
  let nextEvents: unit => array<t>
}

module Movie: {
  module Actor: {
    type t
  }
  module Director: {
    type t
  }

  type t = {
    title: string,
    director: Director.t,
    actors: array<Actor.t>,
  }

  let getInfo: (~title: string) => t
}

module Play: {
  module Playwright: {
    type t
  }

  type t = {
    title: string,
    playwright: Playwright.t,
  }

  let getInfo: (~title: string) => t
}

module Weather: {
  /**
    * an abstract type representing the weather at a given location
    * and a given time
   */
  type t

  let getForecast: (Location.t, Date.t) => t
}

module Affinity: {
  type t
  /**
   * returns a string representation of the affinity score
   */
  let toString: t => string
  /**
    * returns an affinity score between 0 and 1 for a given concert
   */
  let concert: (~artists: array<string>, ~venue: string, ~weather: Weather.t) => t
  /**
    * returns an affinity score between 0 and 1 for a given movie
   */
  let movie: Movie.t => t
  /**
    * returns an affinity score between 0 and 1 for a given play
   */
  let play: (~playwright: Play.Playwright.t, ~director: string, ~actors: array<string>) => t
  /**
    * returns an affinity score between 0 and 1 for a given student party
   */
  let studentParty: (
    ~artists: array<string>,
    ~venue: string,
    ~weather: Weather.t,
    ~affiliatedUniversity: string,
  ) => t
}
