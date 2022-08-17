---
title: "Migration Completed"
date: 2022-08-17T13:50:00+08:00
draft: false
---

OK, I have migrated this blog from Jekyll to hugo. It was a very smooth and simple process.

The main reason for migrating away from Jekyll is I am fed up with it. It needs to establish an entire Ruby environment in order to use it. Like you want to drive a car but you need to build a factory to manufacture the car you want to drive.  

Another thing is, I can never figure out how to run the site locally. It just splits out errors. Hugo and even [mdbook](https://rust-lang.github.io/mdBook/) works flawlessly.

I want to keep the git history of my repo, so my first step is to move everything to a sub-directory called old_sites.

- Then initial it with 

```
hugo new site . --force
```

- Move the old posts to content/posts

- Move the old graphics to static/images

- Update a few links from /assets/images/ to images

That is pretty much it.

A bonus is that I don't need to prepend 中文 titles with an underscore `_`. The reason is that, for I don't know why, if the Title meta data in Jekyll does not start with an alphanumeric charector, it does not display correctly. 

The theme is very minimal as a result of my following of the [quick start](https://gohugo.io/getting-started/quick-start/).
