---
title: "With Typora"
date: 2022-09-13T00:35:21+08:00
draft: false
---

This is my first hugo post written with Typoa. My environment is setup up according to [this post](https://medium.com/@ardianta/writing-using-typora-on-hugo-based-blog-a1be8500774a).


The `layouts/_default/_markup/render-image.html` mentioned in the post is like below:

```
{{ if in .Destination "/static/" }}
<!-- 12 is count of ../../static carachers -->
{{ $new_file_path := substr .Destination 12 }}
<!-- just for testing, you can delete this pre tag -->
<pre>{{ $new_file_path }}</pre>
<!-- render the image with new path -->
<img class="img-fluid" src="{{ $new_file_path }}" alt='{{ .Text }}' />
{{ else }}
<img class="img-fluid" src="{{ .Destination }}" alt='{{ .Text }}' />
{{ end }}
```