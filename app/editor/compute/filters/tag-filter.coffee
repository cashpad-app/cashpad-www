angular
  .module 'geekywallet.editor.tagFilter',[]
  .filter 'tag', () ->
    (lines, tag) ->
      if tag? and tag.length > 0
        tagsRegExp = tag.replace(/#/, '')
          .split(' ')
          .map((tag) -> '#.*' + tag + '.*')
          .join('|')
          
        toReturn = []
        for line in lines
          if line.tags?
              for t in line.tags
                if t.match new RegExp tagsRegExp
                  toReturn.push line
                  break
        toReturn
      else
        lines
