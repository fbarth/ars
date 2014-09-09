#!/bin/bash

cd results/
echo "<html><body><h1>Relatórios sobre Análise de Redes Sociais</h1><br>" > index.html
for f in *.html; 
do
	echo "<ol><a href=\"$f\">$f</a></ol>" >> index.html;
done

echo "</body></html>" >> index.html

git checkout gh-pages
git add index.html
git commit -m "Atualizando pagina index"
git push origin gh-pages
