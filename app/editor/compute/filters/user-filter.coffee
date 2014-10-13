angular
  .module 'geekywallet.editor.userFilter',[]
  .filter 'user', () ->
    (lines, user) ->
      if user? and user.length > 0
        users = user.split ' '
        console.log 'users', users

        toReturn = []
        for line in lines
          for u in users
            added = false
            for b in line.beneficiaries
              if b.name.match new RegExp '.*' + u + '.*'
                toReturn.push line
                added = true
                break
            if not added
              for p in line.payers
                if p.name.match new RegExp '.*' + u + '.*'
                  toReturn.push line
                  added = true
                  break
            if added then break
        toReturn
      else
        lines
