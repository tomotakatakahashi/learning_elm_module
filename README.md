# Elm module trial

```
elm-init
git init
```

1. Develop Increment.elm
    - Make src/Increment.elm
    - Make increment.html
    - elm-live src/Increment.elm -- --output increment.js
2. Develop Decrement.elm
3. Develop Main.elm using Increment and Decrement
    - Make src/Increment.elm and src/Decrement.elm `exposing (..)`
    - elm-live src/Main.elm src/Increment.elm src/Decrement.elm -- --output main.js

Ports are used just for test.
