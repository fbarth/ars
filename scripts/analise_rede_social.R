library(igraph)
relacoes <- read.csv('data//relacoes.csv', sep=';')

g <- graph.data.frame(relacoes, directed=TRUE)
plot(g, edge.width=E(g)$weight)
plot(g, layout=layout.kamada.kawai, edge.width=E(g)$width, edge.color="black")

# O grafo possui a seguinte quantidade de nodos e arestas:

vcount(g)
ecount(g)
is.connected(g)

# O _longest path_ do grafo e os nodos que estão mais longe entre si são apresentados abaixo:

diam <- diameter(g)
diam
nodes <- farthest.nodes(g)
nodes
V(g)[nodes[1]]
V(g)[nodes[2]]

# Calculando o _average path length_:
  
aver_path <- average.path.length(g, directed=TRUE, unconnected=TRUE)
aver_path

#O resultado é `r aver_path`. O que isto significa? 
#It is defined as the average number of steps along the shortest 
#paths for all possible pairs of network nodes. It is a measure of 
# the efficiency of information or mass transport on a network.

d = degree(g, mode = 'all')
hist(d, breaks=200, ylab="Quantidade de nodos", xlab="Degree", 
     main="Distribuição de degree dos nodos")

#plot(degree.distribution(g, mode="all"), log="xy",
#     xlab = "Degree (log)", ylab = "Probabilidade (log)", col = 1, 
#     main = "Distribuição do Degree")

# Calcula o betweenness dos nodos e imprime os nodos com maior e menor betweenness: 
  
betweenness<-betweenness(g,V(g),TRUE,NULL,TRUE,FALSE)
which.max(betweenness)
which.min(betweenness)

# Betweenness centrality is an indicator of a node's centrality in a network. It is equal 
# to the number of shortest paths from all vertices to all others that pass through that node. 
# Betweenness centrality is a more useful measure (than just connectivity) of both the load and 
# importance of a node.

#Quantos clusters o grafo possui?
no.clusters(g)


# Qual é o tamanho destes clusters?
clusters(g)$csize

degree(g, mode="all")
degree(g, mode="in")
degree(g, mode="out")

cl <- clusters(g)
plot(g, layout=layout.kamada.kawai, edge.width=E(g)$width, edge.color="black", vertex.color=cl$membership)

# outro grafo
g1 <- graph.full.citation(100, directed=TRUE)





