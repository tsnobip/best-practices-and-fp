Console.log("Bienvenue dans votre agenda personnalisé !")
MyAgenda.oneRecommendationEveryDay(~maxDistanceInKm=5.0, ~maxPrice=40.0)->Array.forEach(({
  MyAgenda.Event.startDate: startDate,
  name,
  price,
  venue,
}) =>
  Console.log(
    `${Date.toLocaleString(startDate)} : ${name} - ${venue} - ${Float.toString(price)}€`,
  )
)