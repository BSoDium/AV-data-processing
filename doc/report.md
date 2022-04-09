- [Estimation de paramètres](#estimation-de-paramètres)
  - [Introduction](#introduction)
  - [Structure du code](#structure-du-code)
  - [Méthodes impémentées](#méthodes-impémentées)
    - [Implémentation de `moindres_carres`](#implémentation-de-moindres_carres)
    - [Implémentation de `erreur_apprentissage`](#implémentation-de-erreur_apprentissage)
    - [Implémentations de `erreur_generalisation` et `estimation_d_sigma`](#implémentations-de-erreur_generalisation-et-estimation_d_sigma)
    - [Implémentations de `calcul_VC` et `estimation_d_sigma_bis`](#implémentations-de-calcul_vc-et-estimation_d_sigma_bis)
- [Contrôle de la complexité par régularisation](#contrôle-de-la-complexité-par-régularisation)
  - [Introduction](#introduction-1)
  - [Structure du code](#structure-du-code-1)
  - [Méthodes implémentées](#méthodes-implémentées)
    - [Implémentation de `moindes_carres_ecretes`](#implémentation-de-moindes_carres_ecretes)
    - [Implémentation de `calcul_VC` et `estimation_d_sigma_bis`](#implémentation-de-calcul_vc-et-estimation_d_sigma_bis)


# Estimation de paramètres

## Introduction

Cette première partie se donne pour but d'étudier le processus d'estimation des paramètres d'une courbe de Bézier de degré variable, ainsi que des méthodes permettant le choix de son degré.

## Structure du code

Pour des raisons de clarté du code, des choix d'organisation ont été faits afin d'améliorer la structure du projet. Ainsi, la majorité les fonctions fournies avec les sources ont été rassemblées dans la classe `Lib`.

Voici donc l'API de `Lib` utilisée dans les fonctions détaillées ci-dessous:

```yaml
Sealed class Lib:
  Static methods:
    Lib : bernstein(x, d, i) # Polynome de Bernstein (cf documentation)
    Lib : bezier(beta_0, beta, beta_d, x) # Courbe de Bézier (f dans le sujet)
    Lib : gNoise(input, sigma) # Générateur de bruit gaussien additif
    Lib : mean_square_error(input, output) # Erreur quadratique moyenne
```

Ainsi qu'un exemple d'utilisation :

```matlab
y = Lib.gNoise(Lib.bezier(beta_0, beta, beta_d, x), sigma);
```

## Méthodes impémentées

### Implémentation de `moindres_carres`

Après exécution du script `exercice_1`, on obtient une solution approchée de $\hat{\beta}$ qui produit la courbe de Bézier suivante, de degré $d = 20$ choisi au préalable :

![run exercice 1 d=20](res/TP1/run_1_d20.svg)

La courbe précédente est très clairement biaisée par un surentrainement. Selon la même logique, pour des valeurs de $d$ faibles, on obtient un modèle sous-entrainé, comme le montre le résultat suivant, obtenu pour $d = 2$ :

![run exercice 1 d=2](res/TP1/run_1_d2.svg)

On se rend cependant très rapidement compte de la nécessité de choisir une valeur du degré plus adaptée, comme par exemple $d = 8$, dont la courbe associée est visible ci-dessous :

![run exercice 1 d=8](res/TP1/run_1_d8.svg)

Ce résultat est bien plus satisfaisant, et semble coller bien mieux à la courbe du modèle exact.

### Implémentation de `erreur_apprentissage`

L'exécution du script `exercice_2` permet de visualiser l'évolution de l'erreur quadratique moyenne d'apprentissage en fonction du degré de la courbe de Bézier.

![run exercice 2](res/TP1/run_2.svg)

C'est un résultat cohérent, puisque l'erreur décroit en fonction du degré de la courbe de Bézier. Il est cependant pertinent de noter qu'elle varie considérablement moins à partir de $d = 5$.

### Implémentations de `erreur_generalisation` et `estimation_d_sigma`

Lorsque l'on exécute le script `exercice_3`, faisant appel à `erreur_generalisation` et `estimation_d_sigma`, on s'aperçoit que l'erreur de généralisation, contrairement à l'erreur d'apprentissage, a tendance à croitre à partir d'une certaine valeur de $d$, en l'occurence passé le seuil $d_{max} \approx 8$.

![run exercice 3](res/TP1/run_3.svg)

Cette propriété est très avantageuse, puisqu'elle pourait nous permettre d'éviter de surentrainer notre modèle, et ainsi de l'améliorer.

### Implémentations de `calcul_VC` et `estimation_d_sigma_bis`

Le script `exercice_4` met en évidence l'utilité de la *cross validation approach* (approche par validation croisée) *leave-one-out* pour l'estimation des paramètres d'une courbe de Bézier. En effet, elle permet de clairement distinguer les valeurs de $d$ pour lesquelles on peut parler de sur-apprentissage et celle pour lesquelles il s'agit d'une sur-généralisation.

![run exercice 4](res/TP1/run_4.svg)

# Contrôle de la complexité par régularisation

## Introduction

Dans la partie précédente, on avait exploré deux méthodes d'estimation du degré d'une courbe de Bézier, par minimisation de l'erreur de généralisation ou de la validation croisée. On se donne maintenant pour but d'étudier une approche différente, celle de régularisation.

## Structure du code

## Méthodes implémentées

### Implémentation de `moindes_carres_ecretes`

### Implémentation de `calcul_VC` et `estimation_d_sigma_bis`
