# Chinese Postman Problem (WASM)

Adapted from [dilsonpereira/chinese-postman-problem](https://github.com/dilsonpereira/chinese-postman-problem), compiled with emscriptem  / web assembly, and converted into npm module - module will find the shortest path (lowest cost) along all edges between nodes.

Function is called with three arguments: 

```javascript
/*
	1) number of nodes / vertices 
	2) number of edges / connections 
	3) list of connections as [ [ from, to, cost ] or { from, to, cost } ]
*/
```

Example:

```javascript

import cpp from './index.js'

const numberOfNodes = 10
const numberOfEdges = 15

const nodesAndCosts = [
    [ 0, 1, 1 ], // node A, node B, cost or distance
    [ 0, 4, 3 ],
    [ 1, 2, 0 ],
    [ 1, 4, 10 ],
    [ 2, 3, 9 ],
    [ 2, 5, 2 ],
    [ 2, 6, 7 ],
    [ 3, 6, 3 ],
    [ 4, 5, 4 ],
    [ 4, 7, 2 ],
    [ 5, 7, 6 ],
    [ 6, 8, 4 ],
    [ 6, 9, 2 ],
    [ 7, 8, 1 ],
    [ 8, 9, 5 ]
]


const result = await cpp( numberOfNodes, numberOfEdges, nodesAndCosts )

// returns { totalCost: integer, result: [ ... ] }

```

