#!/bin/bash
cp -rf scripts/figure results/
cp scripts/*.html results/
git branch gh-pages
git checkout gh-pages
git add results/
git commit -m "Nova versao resultados"
git push origin gh-pages