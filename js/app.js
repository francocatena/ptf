/* global require */

import './font_awesome'

const app  = require('../elm/src/Main.elm')
const node = document.getElementById('elm-app')

app.Elm.Main.init({node})
