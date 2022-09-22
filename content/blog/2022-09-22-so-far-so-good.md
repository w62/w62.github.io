---
title: "So Far So Good"
date: 2022-09-22T19:29:44+08:00
draft: false
---

In the last a couple of days, I have been researching about writing in [markdown](https://www.markdownguide.org/) and [asciidoc](https://asciidoc.org/). The general approach is to get the respective toolchain working, then find a hosting site.

I now ended up with two blogs. This very one that you are reading and another [asciidoc](https://adoc.freepackets.net/). 

My ultimate goal is to have a blog that supports

- markdown  
- asciidoc 
- [mermaid](https://mermaid-js.github.io/mermaid/)  
- hosting in, say, netlify, github pages, gitlab pages, with automated CI/CD   
- resize the image properly  

[Hugo](https://gohugo.io/) does have asciidoc support but why another blog?Under the hood, hugo uses [asciidoctor](https://asciidoctor.org/) as and extension or add-on functionalities to render the asciidoc. That is to say, it does not support asciidoc natively, viz., the functionality is not built-in has part of the single hugo binary. 

Most [hugo themes](https://themes.gohugo.io/) does not display [asciidoc](https://docs.asciidoctor.org/asciidoc/latest/blocks/admonitions/) well,or correctly. [antora default ui hugo theme](The https://github.com/basil/antora-default-ui-hugo-theme) displays it properly, yet it cannot resize the image in markdown posts. It just display the image with actual image size!

So from now on, writing in asciidoc. Problem solved. Not actually. There are tones of markdown editors around yet most asciidoc writing workflows recommends asciidoc extensions or plugins with VS code, IntellJ even atom.  I like something simple and succnint like [Byword](https://bywordapp.com/). On the rendering side, most asciidoc support are theme dependent and my milage varies with the various themes.  Hugo offers so much flexibilities that the different themes handles content differently. IMHO, it backfires a little bit in this end. At one point I have got more that five versions of config.toml files.

I come to the conclusion that asciidoc is not ready in hugo yet.

So I spent something with [antora](https://antora.org/) - the asciidoc focused static site generator. It has excellent asciidoc support and render everything properly. The down side is, lightweight web server functionalities are **NOT** included. I need to figure out a way to serve the generated page! Another thing is, it does not play well with the CI/CD solutions from various hosting vendors that supports hugo except [git](https://gitlab.com). 

It does not work with gitlab in the first place. After some troubleshooting, the new repo created in gitlab needs to be pulled to the local machine before it can be pushed back. I found out the hard way. Once I can push the repo to gitlab, things are plug and play. If my asciidoc posts do not have syntax error, then all it needs is to push the repo to gitlab.

It is designed for writing books and not writing blogs. It is tightly integrated with git and git service providers which means that it is for technical writers. I will keep it as I want to flex my muscle on the knowledge of antora. Yet my main blog writing activities will happen here in the future.

OK, so far so good.