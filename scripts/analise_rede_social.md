Pequeno exemplo sobre Análise de Redes Sociais
========================================================

O objetivo deste documento é exemplificar o cálculo de atributos de redes sociais. Os exemplos foram implementados utilizando a linguagem de programação *R* e o pacote *igraph*.


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
## [1] 16
```

```r
qtd_aresta <- ecount(g)
qtd_aresta
```

```
## [1] 19
```

```r
is.connected(g)
```

```
## [1] FALSE
```


O grafo possui 16 nodos, 19 arestas e não é conectado.

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
## [1]  5 14  3
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
## [1] 1.37
```


* considerando também os caminhos faltantes. Neste caso, considera-se o tamanho de um caminho faltante como sendo _vcount(graph)_. 


```r
aver_path <- average.path.length(g, directed = TRUE, unconnected = FALSE)
aver_path
```

```
## [1] 14.35
```


O número de seguidores (in-degree), o número de seguidos (out-degree) e o número de conexões de uma pessoa podem ser facilmente calculados da seguinte forma:


```r
degree(g, mode = "in")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         2         0         0         0         1         1         0 
##  marcello      kuma    marcel  fabricio   antonio     alice      jose 
##         2         0         1         0         3         4         1 
##     ronie    sidney 
##         3         1
```

```r
degree(g, mode = "out")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         1         2         2         1         1         2         2 
##  marcello      kuma    marcel  fabricio   antonio     alice      jose 
##         2         1         1         3         1         0         0 
##     ronie    sidney 
##         0         0
```

```r
degree(g, mode = "all")
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         3         2         2         1         2         3         2 
##  marcello      kuma    marcel  fabricio   antonio     alice      jose 
##         4         1         2         3         4         4         1 
##     ronie    sidney 
##         3         1
```


Betweenness is a centrality measure of a vertex within a graph (there is also edge betweenness, which is not discussed here). Betweenness centrality quantifies the number of times a node acts as a bridge along the shortest path between two other nodes. It was introduced as a measure for quantifying the control of a human on the communication between other humans in a social network by Linton Freeman[16] In his conception, vertices that have a high probability to occur on a randomly chosen shortest path between two randomly chosen vertices have a high betweenness.


```r
betweenness(g, directed = TRUE)
```

```
##       bob     cecil     david esmeralda    carlos     maria      joao 
##         0         0         0         0         0         3         0 
##  marcello      kuma    marcel  fabricio   antonio     alice      jose 
##         3         0         0         0         4         0         0 
##     ronie    sidney 
##         0         0
```



A _reciprocity_ de um usuário é calculado como $R(x) = \frac{|Out(x) \in In(x)|}{|Out(x)|}$ onde $Out(x)$ é o conjunto de usuários que o usuário $x$ segue e $In(x)$ é o conjunto de usuários que segue $x$. _Reciprocity_ mede a probabilidade de um usuário ser seguido por usuários que ele segue.


```r
reciprocity(g)
```

```
## [1] 0.1053
```


A _assortativity_ de um nodo é definido como a razão entre o (in/out) degree e a média do (in/out) degree dos seus vizinhos. Podemos calcular a _assortativity_ para quatro tipos de degree-degree correlação (i.e., in-in, in-out, out-in e out-out).


*falta pagerank e hits*
