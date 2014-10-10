angular
  .module 'geekywallet.editor.tagFilter',[]
  .filter 'tag', () ->
    (data, tag) ->
      if tag? and tag.length > 0
        tagsRegExp = tag.replace(/#/, '')
          .split(' ')
          .map((tag) -> '#.*' + tag + '.*')
          .join('|')
        toReturn = []
        for path in data
          newPath = []
          for item in path
            if item.tags?
              for t in item.tags
                if t.match new RegExp tagsRegExp
                  newPath.push item
                  break
          if newPath.length > 0 then toReturn.push newPath
        toReturn
      else
        data
