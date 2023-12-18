module Event: {
  /**
    * An simplified type for an event
    * to be used for a 
   */
  type t = {
    /**
      * The name of the event.
     */
    name: string,
    /**
      * The date and time when the event starts
     */
    startDate: Date.t,
    /**
      * The name of the event venue
     */
    venue: string,
    /**
      * The price (in euros) of the event (per person)
     */
    price: float,
    /**
      * The affinity score of the event
     */
    affinity: API.Affinity.t,
  }
}

/**
 * Returns the top recommended event of each of the next few days
 */
let oneRecommendationEveryDay: (~maxDistanceInKm: float, ~maxPrice: float) => array<API.Event.t>
