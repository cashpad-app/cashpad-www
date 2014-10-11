angular
  .module 'geekywallet.editor.userFilter',[]
  .filter 'user', () ->
    (data, user) ->
      if user? and user.length > 0
        users = user.split ' '
        toReturn = []
        for path in data
          for u in users
            if path[0].user.match new RegExp '.*' + u + '.*'
              toReturn.push path
              break

        toReturn
      else
        data
