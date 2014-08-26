angular
  .module 'geekywallet.editor.palette', []
  .factory '$palette', ->
    shuffle = (array) ->
      for i in [array.length-1..1]
          j = Math.floor Math.random() * (i + 1)
          [array[i], array[j]] = [array[j], array[i]]
      array

    palette = [
      '#FDD7E4',
      '#B5ECCE',
      '#C5DCFF',
      '#DFFFFF',
      '#FFFFCA',
      '#FEDEB0'
    ]

    random: ->
      current = shuffle palette

      get: (i) -> current[i % current.length]