angular
  .module 'geekywallet.editor.datesFilter',[]
  .filter 'dates', () ->
    (lines, fromDate, untilDate) ->
      if lines? and lines.length > 0 and (fromDate? or untilDate?)
        toReturn = []
        for line, index in lines
          if line.date? and (!fromDate? or fromDate <= line.date) and ((!untilDate? and fromDate?) or untilDate >= line.date)
            toReturn.push line
        toReturn
      else
        lines
