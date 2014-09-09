Pequeno exemplo sobre Análise de Redes Sociais (evolução 1)
========================================================

O objetivo deste documento é exemplificar o cálculo de atributos de redes sociais. Os exemplos foram implementados utilizando a linguagem de programação *R* e o pacote *igraph* (http://igraph.org/r/doc/).


```r
library(igraph)
relacoes <- read.csv("../data//relacoes_evol1.csv", sep = ";")
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
## [1] 27
```

```r
is.connected(g)
```

```
## [1] FALSE
```


O grafo possui 19 nodos, 27 arestas e não é conectado.

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
## [1] 1.612
```


* considerando também os caminhos faltantes. Neste caso, considera-se o tamanho de um caminho faltante como sendo _vcount(graph)_. 


```r
aver_path <- average.path.length(g, directed = TRUE, unconnected = FALSE)
aver_path
```

```
## [1] 16.51
```


O número de seguidores (in-degree), o número de seguidos (out-degree) e o número de conexões de uma pessoa podem ser facilmente calculados da seguinte forma:


```r
degree(g, mode = "in")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         2         0         0         0         1         1         0 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##         3         0         1         0         3         2         2 
##  fernanda     alice      jose     ronie    sidney 
##         2         5         1         3         1
```

```r
degree(g, mode = "out")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         1         2         2         1         1         2         2 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##         2         1         1         3         3         2         2 
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
##         5         1         2         3         6         4         4 
##  fernanda     alice      jose     ronie    sidney 
##         4         5         1         3         1
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
## [1] 0.2963
```


Autoridades e hubs:


```r
authority_values <- authority.score(g)$vector
authority_values
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
## 4.386e-01 0.000e+00 0.000e+00 0.000e+00 0.000e+00 2.566e-01 0.000e+00 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
## 4.266e-01 0.000e+00 1.050e-01 0.000e+00 0.000e+00 0.000e+00 0.000e+00 
##  fernanda     alice      jose     ronie    sidney 
## 0.000e+00 1.000e+00 1.354e-17 1.573e-01 2.828e-02
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
## 5.941e-01 8.547e-01 8.547e-01 5.941e-01 0.000e+00 0.000e+00 0.000e+00 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
## 1.102e-01 9.343e-02 2.535e-01 4.093e-01 1.000e+00 0.000e+00 0.000e+00 
##  fernanda     alice      jose     ronie    sidney 
## 0.000e+00 1.821e-16 3.567e-17 1.135e-16 3.567e-17
```

```r
which.max(hub_values)
```

```
## antonio 
##      12
```

```r
which.min(hub_values)
```

```
## carlos 
##      5
```


Pagerank:


```r
page_rank_values <- page.rank(g)$vector
page_rank_values
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##   0.03525   0.01906   0.01906   0.01906   0.02715   0.03785   0.01906 
##  marcello      kuma    marcel  fabricio   antonio    thiago    felipe 
##   0.06403   0.01906   0.02446   0.01906   0.06632   0.12704   0.12704 
##  fernanda     alice      jose     ronie    sidney 
##   0.12704   0.10021   0.03514   0.06787   0.04627
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
## [1] 2
```



```r
plot(g, layout = layout.kamada.kawai, edge.width = E(g)$width, edge.color = "black", 
    vertex.color = cl$membership)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 

