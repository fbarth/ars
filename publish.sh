#!/bin/bash
cp -rf scripts/figure results/
cp scripts/*.html results/
git checkout master
git add .
git commit -m "Nova versao resultados"
git push origin master
git checkout gh-pages
git merge master
git push origin gh-pages
git checkout master