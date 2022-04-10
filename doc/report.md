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
    - [Implémentation de `calcul_VC_bis` et `estimation_lambda_sigma`](#implémentation-de-calcul_vc_bis-et-estimation_lambda_sigma)
    - [Implémentation de `moindres_carres_bis` et simulation de la silhouette d'une flamme de bougie](#implémentation-de-moindres_carres_bis-et-simulation-de-la-silhouette-dune-flamme-de-bougie)
    - [Implémentation de `estimation_lois_n` et `simulation`](#implémentation-de-estimation_lois_n-et-simulation)


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
<figcaption align="center">
  <b>Fig. 1 : Courbe de Bézier de degré d = 20</b>
</figcaption>

___

La courbe précédente est très clairement biaisée par un surentrainement. Selon la même logique, pour des valeurs de $d$ faibles, on obtient un modèle sous-entrainé, comme le montre le résultat suivant, obtenu pour $d = 2$ :

![run exercice 1 d=2](res/TP1/run_1_d2.svg)
<figcaption align="center">
  <b>Fig. 2 : Courbe de Bézier de degré d = 2</b>
</figcaption>

___

On se rend cependant très rapidement compte de la nécessité de choisir une valeur du degré plus adaptée, comme par exemple $d = 8$, dont la courbe associée est visible ci-dessous :

![run exercice 1 d=8](res/TP1/run_1_d8.svg)
<figcaption align="center">
  <b>Fig. 3 : Courbe de Bézier de degré d = 8</b>
</figcaption>

___

Ce résultat est bien plus satisfaisant, et semble coller bien mieux à la courbe du modèle exact.

### Implémentation de `erreur_apprentissage`

L'exécution du script `exercice_2` permet de visualiser l'évolution de l'erreur quadratique moyenne d'apprentissage en fonction du degré de la courbe de Bézier.

![run exercice 2](res/TP1/run_2.svg)
<figcaption align="center">
  <b>Fig. 4 : Erreur quadratique moyenne d'apprentissage en fonction du degré</b>
</figcaption>

___

C'est un résultat cohérent, puisque l'erreur décroit en fonction du degré de la courbe de Bézier. Il est cependant pertinent de noter qu'elle varie considérablement moins à partir de $d = 5$.

### Implémentations de `erreur_generalisation` et `estimation_d_sigma`

Lorsque l'on exécute le script `exercice_3`, faisant appel à `erreur_generalisation` et `estimation_d_sigma`, on s'aperçoit que l'erreur de généralisation, contrairement à l'erreur d'apprentissage, a tendance à croitre à partir d'une certaine valeur de $d$, en l'occurence passé le seuil $d_{max} \approx 8$.

![run exercice 3](res/TP1/run_3.svg)
<figcaption align="center">
  <b>Fig. 5 : Erreur de généralisation en fonction du degré</b>
</figcaption>

___

Cette propriété est très avantageuse, puisqu'elle pourait nous permettre d'éviter de surentrainer notre modèle, et ainsi de l'améliorer.

### Implémentations de `calcul_VC` et `estimation_d_sigma_bis`

Le script `exercice_4` met en évidence l'utilité de la *cross validation approach* (approche par validation croisée) *leave-one-out* pour l'estimation des paramètres d'une courbe de Bézier. En effet, elle permet de clairement distinguer les valeurs de $d$ pour lesquelles on peut parler de sur-apprentissage et celle pour lesquelles il s'agit d'une sur-généralisation.

![run exercice 4](res/TP1/run_4.svg)
<figcaption align="center">
  <b>Fig. 6 : Validation croisée en fonction du degré</b>
</figcaption>

___

# Contrôle de la complexité par régularisation

## Introduction

Dans la partie précédente, on avait exploré deux méthodes d'estimation du degré d'une courbe de Bézier, par minimisation de l'erreur de généralisation ou de la validation croisée. On se donne maintenant pour but d'étudier une approche différente, celle de régularisation.

## Structure du code

Dans cette partie, ainsi que la majorité des suivantes, on a gardé la structure d'origine, très monolithique et simple, majoritairement par manque de temps.
C'est d'ailleurs pour la même raison que les tâches facultatives n'ont pas été abordées.
## Méthodes implémentées

### Implémentation de `moindes_carres_ecretes`

Ici, on a fait le choix de ne plus travailler avec $\beta$ mais avec $\delta$, tq
$$
\left\{
  \begin{array}{ll}
    \hat{\beta} = \argmin_{\beta = \beta_1 ... \beta_{d-1}} \|A\beta^\top - C\|^2\\
    \hat{\delta} = \argmin_{\delta = \delta_1 ... \delta_{d-1}} \|A\delta^\top - C\|^2
  \end{array}
\right.
\newline
\text{avec } C = B - A\overline{\beta}^\top
$$

La fonction `moindres_carres_ecretes` détermine la valeur de $\hat{\beta}$ en appliquand le principe de la *ridge regression* (regression regression). Un hyperparamètre $\lambda$ est ajouté afin de pénaliser les écarts $\delta_i$ les plus importants.

L'exécution suivante du script `exercice_1`, mettant en oeuvre cette méthode, affiche des résultats bien plus satisfaisant que les précédents pour une valeur de lambda faible (0.05).
![run exercice 1](res/TP2/run_1.svg)
<figcaption align="center">
  <b>Fig. 7 : Résultats de la méthode moindres_carres_ecretes</b>
</figcaption>

___

En faisant varier lambda dans l'intervalle $[0, 100]$, on constate que plus le lambda est grand, plus la courbe obtenue se rapproche d'une droite reliant les points $P_0$ et $P_d$, comme le montre l'image ci-dessous, prise pour un lambda de $100$.
![run exercice 1 haut lambda](res/TP2/run_1_lambda_100.svg)
<figcaption align="center">
  <b>Fig. 8 : Résultats de la méthode moindres_carres_ecretes pour un lambda très élevé</b>
</figcaption>

___

### Implémentation de `calcul_VC_bis` et `estimation_lambda_sigma`

On s'intéresse maintenant au calcul de la validation croisée définie, rappelons-le, par l'expression suivante :
$$
VC = \frac{1}{n_{app}} \sum_{i=1}^{n_{app}} [y_j - f(\beta_0^*, \hat{\beta}_j, \beta_d^*, x_j)]^2
$$
que nous appliquons dans la fonction `calcul_VC_bis`. Quant à `estimation_lambda_sigma`, elle ne fait que récupérer l'indice et la valeur du minimum de la liste et les renvoyer casiment tel quel :
```matlab
[m, ind] = min(liste_VC);
lambda_optimal = liste_lambda(ind);
sigma_estime = sqrt(m);
```
![run exercice 2](res/TP2/run_2.svg)
<figcaption align="center">
  <b>Fig. 9 : Résultats obtenus après estimation de lambda et de sigma d'après les valeurs de VC</b>
</figcaption>

___

![run exercice 2 VC lambda](res/TP2/run_2_VC_lambda.svg)
<figcaption align="center">
  <b>Fig. 10 : Valeurs de VC obtenues en fonction de lambda</b>
</figcaption>

___


### Implémentation de `moindres_carres_bis` et simulation de la silhouette d'une flamme de bougie

Pour modéliser l'évolution de la flamme de bougie, on utilise la reformulation du problème proposée par le sujet.
$$
  E^q X^q = F^q
$$
où $X^q$ contient les vecteurs de paramètres $\beta^q$ et $\gamma^q$ concaténés, soit $X^q = [\beta_1^q,...,\beta_{d-1}^q, \gamma_1^q, ..., \gamma_d^q]^\top$ (on a retiré le $\beta_d^q$ par soucis d'optimisation, puisqu'il est égal à $\gamma_d^q$).

Notre implémentation nous permet ainsi d'obtenir une animation en exécutant le script `exercice_2`, dont quelques images sont affichées ci-dessous.

|                          |                          |
| :----------------------: | :----------------------: |
| ![](res/TP2/run_3_a.svg) | ![](res/TP2/run_3_b.svg) |
| ![](res/TP2/run_3_c.svg) | ![](res/TP2/run_3_d.svg) |
### Implémentation de `estimation_lois_n` et `simulation`

Le corps de la fonction `estimation_lois_n` est assez concis, puisque le calcul des moyennes et des écart types peut se faire à l'aide de fonctions déjà implémentées dans matlab, en l'occurrence, `mean` et `std` (standard deviation) :
```matlab
ecarts_types = std(X);
moyennes = mean(X);
```

La fonction simulation associe aux vecteurs de paramètres $\beta^q$ et $\gamma^q$ deux vecteurs de positions des points de la flamme de bougie, côté gauche et côté droit. Le résultat obtenu est, encore une fois, affiché ci-dessous :
![run exercice 3](res/TP2/run_4.svg)
<figcaption align="center">
  <b>Fig. 11 : Capture d'écran de l'animation obtenue (script exercice_4)</b>
</figcaption>

___

Le script `sequence_flammes` ajoute de la couleur à l'animation précédente, nous montrant l'intérêt de cette étude, ainsi que les nombreuses applications qu'elle pourrait avoir, dans le monde des jeux video par exemple. Ci-dessous, on peut voir une capture d'écran de l'animation finale :
![run exercice 3 sequence](res/TP2/run_4_colored.svg)
<figcaption align="center">
  <b>Fig. 12 : Capture d'écran de l'animation obtenue (script sequence_flammes) avec couleur</b>
</figcaption>

___

