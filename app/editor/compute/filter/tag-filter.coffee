angular
  .module 'geekywallet.editor.tagFilter',[]
  .filter 'tagFilter', () ->
    (data, tag) ->
      # console.log 'inside userFilter'
      toReturn = []
      console.log tag
      for path in data
        newPath = []
        for item in path
          if tag in item.tags then newPath.push item
        toReturn.push newPath

      toReturn