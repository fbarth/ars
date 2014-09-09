Pequeno exemplo sobre Análise de Redes Sociais
========================================================

O objetivo deste documento é exemplificar o cálculo de atributos de redes sociais. Os exemplos foram implementados utilizando a linguagem de programação *R* e o pacote *igraph* (http://igraph.org/r/doc/).


```r
library(igraph)
relacoes <- read.csv("../data//relacoes.csv", sep = ";")
g <- graph.data.frame(relacoes, directed = TRUE)
```


O grafo didático criado possui a seguinte estrutura:


```r
plot(g, layout = layout.kamada.kawai, edge.width = E(g)$weight, edge.color = "black")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 



```r
qtd_vertice <- vcount(g)
qtd_vertice
```

```
## [1] 19
```

```r
qtd_aresta <- ecount(g)
qtd_aresta
```

```
## [1] 25
```

```r
is.connected(g)
```

```
## [1] FALSE
```


O grafo possui 19 nodos, 25 arestas e não é conectado.

O _longest path_ do grafo e os nodos que estão mais longe entre si são apresentados abaixo:


```r
diam <- diameter(g)
diam
```

```
## [1] 3
```

```r
nodes <- farthest.nodes(g)
nodes
```

```
## [1]  5 17  3
```

```r
V(g)[nodes[1]]
```

```
## Vertex sequence:
## [1] "carlos"
```

```r
V(g)[nodes[2]]
```

```
## Vertex sequence:
## [1] "jose"
```


Um atributo utilizado para medir a eficiência do tráfego de informação de uma rede é o _average path length_.
_average path length_ é definido como o número médio de passos entre os menores caminhos para todos os pares
de nodos possíveis na rede. Quanto menor este número, maior é a eficiência do tráfego de informação na rede.

Podemos calcular o _average path length_ de duas formas:

* considerando apenas o comprimento dos caminhos existentes:


```r
aver_path <- average.path.length(g, directed = TRUE, unconnected = TRUE)
aver_path
```

```
## [1] 1.303
```


* considerando também os caminhos faltantes. Neste caso, considera-se o tamanho de um caminho faltante como sendo _vcount(graph)_. 


```r
aver_path <- average.path.length(g, directed = TRUE, unconnected = FALSE)
aver_path
```

```
## [1] 17.29
```


O número de seguidores (in-degree), o número de seguidos (out-degree) e o número de conexões de uma pessoa podem ser facilmente calculados da seguinte forma:


```r
degree(g, mode = "in")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         2         0         0         0         1         1         0 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##         2         0         1         0         3         2         2 
##  fernanda     alice      jose     ronie    sidney 
##         2         4         1         3         1
```

```r
degree(g, mode = "out")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         1         2         2         1         1         2         2 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##         2         1         1         3         1         2         2 
##  fernanda     alice      jose     ronie    sidney 
##         2         0         0         0         0
```

```r
degree(g, mode = "all")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         3         2         2         1         2         3         2 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##         4         1         2         3         4         4         4 
##  fernanda     alice      jose     ronie    sidney 
##         4         4         1         3         1
```


_Betweenness centrality_ é uma medida que quantifica a centralidade de um vértice (nodo) em um grafo. _Betweeness centrality_ calcula o n'mero de vezes que um nodo atua como ponte no menor caminho entre outros dois nodos. Esta medida foi introduzida por _Linton Freeman [[1]](http://dx.doi.org/10.2307%2F3033543) como uma forma de quantificar o controle de um humano na comunicação entre outros humanos.


```r
betweenness <- betweenness(g, directed = TRUE)
which.max(betweenness)
```

```
## antonio 
##      12
```

```r
which.min(betweenness)
```

```
## bob 
##   1
```


A medida de _reciprocity_ define a proporção de conexões mútuas em um grafo direcionado.


```r
reciprocity(g)
```

```
## [1] 0.32
```


A _assortativity_ de um nodo é definido como a razão entre o (in/out) degree e a média do (in/out) degree dos seus vizinhos. Podemos calcular a _assortativity_ para quatro tipos de degree-degree correlação (i.e., in-in, in-out, out-in e out-out).


```r
assortativity.degree(g)
```

```
## [1] -0.2736
```


Autoridades e hubs:


```r
authority_values <- authority.score(g)$vector
authority_values
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
## 6.180e-01 0.000e+00 0.000e+00 0.000e+00 2.722e-16 1.978e-16 0.000e+00 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
## 1.044e-15 0.000e+00 7.831e-16 0.000e+00 6.832e-16 8.891e-16 8.891e-16 
##  fernanda     alice      jose     ronie    sidney 
## 8.891e-16 1.000e+00 2.315e-16 1.485e-15 4.242e-16
```

```r
which.max(authority_values)
```

```
## alice 
##    16
```

```r
which.min(authority_values)
```

```
## cecil 
##     2
```

```r
hub_values <- hub.score(g)$vector
hub_values
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
## 6.180e-01 1.000e+00 1.000e+00 6.180e-01 3.432e-16 4.701e-16 4.701e-16 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
## 0.000e+00 0.000e+00 0.000e+00 0.000e+00 3.648e-17 5.768e-16 5.768e-16 
##  fernanda     alice      jose     ronie    sidney 
## 5.768e-16 6.993e-17 1.748e-17 1.788e-17 1.748e-17
```

```r
which.max(hub_values)
```

```
## cecil 
##     2
```

```r
which.min(hub_values)
```

```
## marcello 
##        8
```


Pagerank:


```r
page_rank_values <- page.rank(g)$vector
page_rank_values
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##   0.03341   0.01806   0.01806   0.01806   0.02573   0.09162   0.01806 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##   0.04287   0.01806   0.02317   0.01806   0.08654   0.12038   0.12038 
##  fernanda     alice      jose     ronie    sidney 
##   0.12038   0.07715   0.05699   0.05674   0.03628
```

```r
which.max(page_rank_values)
```

```
## thiago 
##     13
```

```r
which.min(page_rank_values)
```

```
## cecil 
##     2
```


Clusters
--------


```r
cl <- clusters(g)
quantidade_clusters <- cl$no
quantidade_clusters
```

```
## [1] 4
```



```r
plot(g, layout = layout.kamada.kawai, edge.width = E(g)$width, edge.color = "black", 
    vertex.color = cl$membership)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 

