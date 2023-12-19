# Programmations fonctionnelle et bonnes pratiques de développement logiciel

Ce dépôt contient les sources de mon cours d'introduction à la programmation fonctionnelle et sur comment
celle-ci peut faciliter le suivi des bonnes pratiques de développement logiciel.

Ce cours est originellement destiné aux élèves de l'École des Mines de Saint-Étienne.

## Consultation

Le cours est accessible en ligne [ici](https://tsnobip.github.io/best-practices-and-fp/).

## Contribution

Si jamais vous souhaitez contribuer à ce cours, vous pouvez forker ce dépôt et
apporter les modifications que vous souhaitez.

Ce cours utilise [reveal.js](https://revealjs.com/) pour la présentation.

Le contenu du cours en lui-même est à retrouver dans `docs/index.html`.

Vous pouvez également créer une issue si jamais vous voyez des coquilles, des erreurs à corriger,
ou si vous avez des commentaires à faire pour améliorer ce cours.

## Exercice

### Instructions

> [!IMPORTANT]
> Vérifiez d'abord que vous votre ordinateur dispose de :
>
> - git
> - node (v16 ou supérieure)
> - vscode

Pour commencer, [forkez](https://github.com/tsnobip/best-practices-and-fp/fork) le dépôt.

Clonez-le sur votre ordinateur :

```
git clone [remplacez-ceci-avec-l'adresse-de-votre-fork]
```

Une fois cela fait, ouvrez le dépôt avec vscode, ouvrez un terminal dans la barre du bas et installez les dépendances:

```
npm install
```

Installez les plugins recommandés.

Pour lancer le compilateur en mode "watch" et voir le résultat de la compilation, faites:

```
npm run res
```

Vous pouvez maintenant aller dans le fichier [MyAgenda.res](exercise/MyAgenda.res) pour
implémenter la fonction `oneRecommendationEveryDay` en obtenant les informations
nécessaires grâce aux fonctions du module [API](exercise/API.resi).

> [!NOTE] Le type `API.Event.t` est volontairement suboptimal, nous en discuterons ensemble lors du prochain cours.

### Rendu

Une fois que vous êtes satisfaits de votre implémentation, faites une Pull Request pour que
je puisse examiner votre code et que nous en discutions au prochain cours.

### ReScript

> [!TIP]
> N'hésitez pas à aller sur la [documentation officielle](https://rescript-lang.org/)
> pour en apprendre plus sur ReScript !

ReScript ressemble globalement à JavaScript, il y a évidemment des différences :

- il est statiquement typé, pensez donc à créer vos types avant de les utiliser
- il est immutable par défaut, il n'y a donc pas de `const`, `let` est déjà constant par défaut
- les fonctions peuvent avoir des paramètres nommés, lisez la [documentation](https://rescript-lang.org/docs/manual/latest/function#labeled-arguments) à ce propos
