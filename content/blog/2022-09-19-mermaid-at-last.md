+++
date = '2022-09-19T16:32:56+08:00'
draft = false
title = 'Mermaid at Last'

+++


At last I have got [mermaid](https://mermaid-js.github.io/mermaid/) working! The bad news is that the [the official guide](https://gohugo.io/content-management/diagrams/#mermaid-diagrams) doesn't work. I am following the recipe from [this post](https://robb.sh/posts/how-to-use-mermaid-diagrams-in-hugo/). It is not that difficult, but it needs to be set up each and everytime. May be I can custom a theme myself. This is the [mermaid flowchart documentation](https://mermaid-js.github.io/mermaid/#/flowchart).


##### Graph

{{<mermaid>}}

graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;

{{</mermaid>}}

##### Sequence Diagram

{{<mermaid>}}

	sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!

{{</mermaid>}}

##### E-R Diagram

{{<mermaid>}}

erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses

{{</mermaid>}}

##### Class Diagram

{{<mermaid>}}

classDiagram
Class01 <|-- AveryLongClass : Cool
Class03 *-- Class04
Class05 o-- Class06
Class07 .. Class08
Class09 --> C2 : Where am i?
Class09 --* C3
Class09 --|> Class07
Class07 : equals()
Class07 : Object[] elementData
Class01 : size()
Class01 : int chimp
Class01 : int gorilla
Class08 <--> C2: Cool label

{{</mermaid>}}
