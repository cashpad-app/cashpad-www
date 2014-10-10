angular
  .module 'geekywallet.editor.userFilter',[]
  .filter 'user', () ->
    (data, user) ->
      console.log 'userFilter', data, user
      # console.log 'inside userFilter'
      toReturn = []
      for path in data
        if path[0].user.match new RegExp '.*' + user + '.*'
          toReturn.push path
          # console.log path
          # console.log path
          # console.log toReturn[0]
          break

      toReturn