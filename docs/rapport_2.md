
- [Abstract](#abstract)
- [Restauration d'images](#restauration-dimages)
  - [Débruitage par variation totale](#débruitage-par-variation-totale)
  - [Inpainting par variation totale](#inpainting-par-variation-totale)
- [Techniques de photomontage](#techniques-de-photomontage)
  - [Photomontage par collage](#photomontage-par-collage)
  - [Décoloration partielle d'une image](#décoloration-partielle-dune-image)
- [Décomposition d'une image](#décomposition-dune-image)
  - [Décomposition par modification de spectre](#décomposition-par-modification-de-spectre)
  - [Décomposition par modèle ROF](#décomposition-par-modèle-rof)
- [Tomographie](#tomographie)
  - [Résolution algébrique](#résolution-algébrique)
  - [Résolution par rétroprojection](#résolution-par-rétroprojection)
- [Compression audio](#compression-audio)
  - [Transformée de Fourier à court terme](#transformée-de-fourier-à-court-terme)
  - [Compression acoustique](#compression-acoustique)
  - [Stéganographie acoustique](#stéganographie-acoustique)
- [Reconnaissance musicale](#reconnaissance-musicale)
  - [Calcul des pics spectraux](#calcul-des-pics-spectraux)
  - [Appariement des pics spectraux](#appariement-des-pics-spectraux)
  - [Reconnaissance musicale (simplifiée)](#reconnaissance-musicale-simplifiée)
- [Séparation de sources](#séparation-de-sources)
  - [Séparation harmoniques et percussives](#séparation-harmoniques-et-percussives)
  - [Décomposition de sonagramme par NMF](#décomposition-de-sonagramme-par-nmf)
- [Conclusion](#conclusion)

# Abstract
Ce rapport présente l'intégralité du travail réalisé dans le cadre des TP 6 à 12 de traitement de données audio-visuelles. Les images et extraits de code utilisés ici sont fournis uniquement à titre d'illustration de mes propos, et ne constituent en aucun cas une solution idéale aux questions posées. Toute utilisation de ces résultats devra donc se faire avec prudence.

# Restauration d'images

## Débruitage par variation totale
La fonction `debruitage` que nous nous sommes dans un premier temps donné pour but d'implémenter minimise la variation totale de l'image, approximation de la régularisation quadratique du modèle "Tikhonov", dont l'expression est la suivante:
$$
\begin{equation}
E_{TV}(u) = \int\int_{\Omega} \bigg\{ \frac{(u(x, y) - u_0(x, y))^2}{2} + \lambda\sqrt{|\nabla u(x, y)|^2 + \epsilon} \bigg\} dx \space dy
\end{equation}
$$

Les résultats obtenus pour une image en noir et blanc (1 unique canal) sont satisfaisants, mais semblent plus fidèles pour un lambda proche de 10 (perte de détail moindre).


![run 15 exercice 1](./res/TP6/run_1_lambda_15.svg)
<figcaption align="center">
  <b>Fig. 1 : Débruitage monocanal pour lambda = 15</b>
</figcaption>

![run 10 exercice 1](./res/TP6/run_1_lambda_10.svg)
<figcaption align="center">
  <b>Fig. 2 : Débruitage monocanal pour lambda = 10</b>
</figcaption>

On peut par la suite appliquer cette méthode à une image en couleur (3 canaux), selon le même principe:

![run 15 exercice 1 bis](./res/TP6/run_1_bis_lambda_15.svg)
<figcaption align="center">
  <b>Fig. 3 : Débruitage 3 canaux pour lambda = 15</b>
</figcaption>


## Inpainting par variation totale

On s'intéresse maintenant à une autre application du modèle utilisé précédemment : l'inpainting. Le but est de réparer une image qui a été détériorée par l'ajout d'un defaut. Dans un premier temps, on utilisera une carte qui permet de localiser ce defaut:

![run 15 exercice 2](./res/TP6/run_2_lambda_15.svg)
<figcaption align="center">
  <b>Fig. 4 : Inpainting - suppression de defaut - pour lambda = 15</b>
</figcaption>

Dans un second temps, on n'utilise plus de carte, mais un critère de couleur qui permet de localiser le defaut. En l'occurence, on utilise ici la couleur jaune **rgb(255, 255, 0)**:

![run 15 exercice 2 bis](./res/TP6/run_2_bis_lambda_15.svg)
<figcaption align="center">
  <b>Fig. 5 : Inpainting - suppression de texte - pour lambda = 15</b>
</figcaption>

![run 15 exercice 2 bis custom](./res/TP6/run_2_bis_custom_lambda_15.svg)
<figcaption align="center">
  <b>Fig. 6 : Inpainting - suppression de defaut - pour lambda = 15</b>
</figcaption>

Cette méthode est très efficace, comme en témoignent les résultats obtenus, cependant elle ne fonctionne que pour des défauts de faible largeur (traits ou texte).

# Techniques de photomontage

## Photomontage par collage

L'approche la plus naïve "colle" une image détourée par à l'aide d'un masque sur une autre image. Un exemple ci-dessous:

![run 0](res/TP7/run_0.svg)
<figcaption align="center">
  <b>Fig. 7 : Photomontage par collage naïf</b>
</figcaption>

Une version plus évoluée de cet algorithme fait appel aux techniques d'inpainting utilisées précédemment, adaptées de façon à adapter les couleurs de l'image détourée à celle de l'image de base.


![run 1](res/TP7/run_1_orca.svg)
![run 1](res/TP7/run_1_macronde.svg)
<figcaption align="center">
  <b>Fig. 8 : Photomontages par collage intelligent</b>
</figcaption>

## Décoloration partielle d'une image

La même fonction collage peut être utilisée pour décolorer une image: On utilise une source et une cible identiques, mais on convertit au préalable l'image cible en niveaux de gris avant de coller. On obtient alors les résultats suivants:

![run 2](res/TP7/run_2_rose.svg)
![run 2](res/TP7/run_2_duck.svg)
<figcaption align="center">
  <b>Fig. 9 : Photomontages par décoloration partielle</b>
</figcaption>

# Décomposition d'une image

Dans cette partie, on se propose d'étudier la décomposition d'une image d'entrée $u$ en deux autres images $\overline{u}$ et $\overline{u}^c$ de tailles identiques à $u$, et telles que leur somme est égale à $u$. Ce sujet est assez large, c'est pourquoi nous nous limiterons ici aux décompositions structure-texture.

## Décomposition par modification de spectre

![run 0](res/TP8/run_0.svg)
<figcaption align="center">
  <b>Fig. 10 : Exemple de modification de spectre d'une grille</b>
</figcaption>

![run 1](res/TP8/run_1.svg)
<figcaption align="center">
  <b>Fig. 11 : Décomposition structure-texture par modification de spectre</b>
</figcaption>

## Décomposition par modèle ROF

Il est toutefois tout à fait possible de séparer structure et texture sans passer par la transformée de Fourier. On peut utiliser une approche variationnelle, en l'occurence le modèle ROF défini comme suit:

$$
\begin{equation}
E_{ROF}(\overline{u}) = \int \int_{\omega} \bigg\{\frac{1}{2} [\overline{u}(x, y) - u(x, y)]^2 + \lambda |\nabla \overline{u}(x, y)|_{\epsilon} \bigg\} \space dx \space dy
\end{equation}
$$

![run 2](res/TP8/run_2.svg)
![run 2 lara croft](res/TP8/run_2_lara.svg)
<figcaption align="center">
  <b>Fig. 13 : Décompositions structure-texture par modèle ROF</b>
</figcaption>

On remarque un très clair lissage de l'image de structure (au milieu), ce qui est cohérent puisque la texture a été retirée. L'image de texture semble récupérer toutes les imperfections de l'image d'origine, un résultat qui correspond encore une fois à nos attentes.

# Tomographie

La tomographie est une technique d'imagerie par sections non destructive, permettant de reconstruire le volume d'un objet à partir de multiple mesures effectuées depuis l'extérieur de celui-ci. Elle fait appel à une transformation, dite "de Radon", qui pour une de ces mesures (en l'occurence, une section) donne sa projection orthogonale 
sur une droite $D$ d'angle polaire $\theta$, moyennant une abscisse $t$.

## Résolution algébrique

Après lancement du script de calcul du sinogramme, et résolution à l'aide de l'algorithme de Kaczmarz, on obtient l'image reconstituée suivante:

![run 1](res/TP9/run_1.svg)
<figcaption align="center">
  <b>Fig. 14 : Tomographie - résolution algébrique</b>
</figcaption>


## Résolution par rétroprojection

On aborde maintenant une approche différente, qui résoud un des inconvénients de la méthode précédente: son manque de rapidité. On calcule ici la somme des contributions des différentes "déprojections" des données:

$$
\begin{equation}
f(x, y) \approx \frac{1}{n_\theta} \sum_{\theta} {p_\theta (x \cos(\theta) + y \sin(\theta))}
\end{equation}
$$

![run 2](res/TP9/run_2.svg)
<figcaption align="center">
  <b>Fig. 15 : Tomographie - résolution par rétroprojection</b>
</figcaption>

# Compression audio

Utilisée presque partout, que ce soit pour le streaming ou le stockage de fichiers sonores volumineux, la compression acoustique est une technique de compression de fichiers qui permet de réduire leur taille.

## Transformée de Fourier à court terme

Dans un premier temps, on calcule et on affiche simplement la transformée de Fourier à court terme d'un signal passé en argument.

![run 1](res/TP10/run_1.svg)
<figcaption align="center">
  <b>Fig. 16 : Transformée de Fourier à court terme</b>
</figcaption>

## Compression acoustique

On tire maintenant parti des limitations des capacités auditives humaines, ce qui nous permet de grandement réduire la taille des fichiers sonores. Ci-dessous, le résultat pour un taux de compression de $0.1$:

![run 2](res/TP10/run_2.svg)
<figcaption align="center">
  <b>Fig. 17 : Compression acoustique</b>
</figcaption>

## Stéganographie acoustique

Un exemple d'utilisation de la compression acoustique est la stéganographie. On utilise l'espace libéré par la compression d'un fichier sonore pour en coder un autre qui est alors caché dans le fichier original:

![run 3](res/TP10/run_3.svg)
<figcaption align="center">
  <b>Fig. 18 : Stéganographie acoustique</b>
</figcaption>


# Reconnaissance musicale

On aborde maintenant une technologie très utilisée de nos jours, notamment par Shazam, qui est la reconnaissance de morceaux de musique à la volée. Pour ce faire, il est nécessaire de définir un système d'empreinte musicale, capable de décrire de façon fiable et facilement identifiable un morceau de musique. On utilise ici les **pics spectraux**.

## Calcul des pics spectraux

Voici le résultat de l'algorithme de calcul des pics spectraux:

![run 1](res/TP11/run_1.svg)
<figcaption align="center">
  <b>Fig. 19 : Calcul des pics spectraux</b>
</figcaption>

## Appariement des pics spectraux

Dans un second temps, on va améliorer notre capacité d'indexation en appariant les pics de façon à créer une signature musicale plus aisément identifiable:

![run 2](res/TP11/run_2.svg)
<figcaption align="center">
  <b>Fig. 20 : Appariement des pics spectraux</b>
</figcaption>

## Reconnaissance musicale (simplifiée)

Malheureusement, les résultats obtenus sont loins d'être satisfaisants. Le script `statistiques.m` affiche un taux de reconnaissance de **25%** ce qui est extrèmement bas. Il s'agit probablement d'une erreur dans mon code, mais je n'ai pas réussi à l'identifier jusque là.

# Séparation de sources

Un signal sonore contient souvent plusieurs sources superposées, qu'il s'agisse de bruits ou de multiples sources de même nature. Il peut donc s'avérer intéressant de chercher à les séparer pour les analyser individuellement.

## Séparation harmoniques et percussives

Il existe plusieurs méthodes pour séparer des sources, une approche simple est la séparation harmonique/percussive:

![run 1 all](res/TP12/run_1_all.svg)
<figcaption align="center">
  <b>Fig. 21 : Spectre du signal d'origine</b>
</figcaption>

![run 1](res/TP12/run_1.svg)
<figcaption align="center">
  <b>Fig. 22 : Séparation harmoniques et percussives - masques appliqués</b>
</figcaption>

![run 1 out](res/TP12/run_1_out.svg)
<figcaption align="center">
  <b>Fig. 23 : Séparation harmoniques et percussives - Spectre des signaux séparés</b>
</figcaption>


## Décomposition de sonagramme par NMF

On se propose désormais d'afficher à partir du sonagramme d'un enregistrement une paire de matrices, $D$ et $A$ telles que $S \approx D A$ suivant la méthode de factorisation *en matrices non négatives* (dite NMF). les colonnes de $D$ contiennent le spectre de chaque source (en l'occurence de chaque note puisqu'on s'est arrangé pour qu'il y ait le même nombre de colonnes que de notes dans l'extrait). $A$ quant à lui est une représentation MIDI approximative de la partition. Ci-dessous, le résultat pour le sonagramme d'un extrait de *Au clair de la lune*.

![run 2](res/TP12/run_2.svg)
<figcaption align="center">
  <b>Fig. 24 : Décomposition NMF d'Au clair de la lune</b>
</figcaption>

# Conclusion

Cette étude a été très intéressante, et m'a permis d'aborder une multitude de problématiques du traitement de données audio-visuelles aussi passionnantes que variées. J'aurais aimé pouvoir y consacrer plus de temps, et faire notamment les parties facultatives des TP, mais le travail requis dans les autres matières ne m'a pas permis de le faire.
