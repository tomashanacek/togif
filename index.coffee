{exec} = require 'child_process'
escape = require 'shell-escape'
path = require 'path'
temp = require('temp').track()


togif = (input, output, options, callback) ->
  rate = options.rate or 10
  ffmpeg = options.ffmpeg or 'ffmpeg'

  input = escape([input])
  output = escape([output])

  temp.mkdir {}, (err, tempDir) ->
    return callback(err) if err

    palettePath = path.join(tempDir, '/palette.png')

    filters = "fps=#{rate}"

    if options.width
      filters += ",scale=#{options.width}:-1:flags=lanczos"

    cmd = [ffmpeg]
    cmd.push('-i', input)
    cmd.push('-vf', '"' + filters + ',palettegen"')
    cmd.push('-y', palettePath)
    cmd = cmd.join(' ')

    exec cmd, (err) ->
      return callback(err) if err

      cmd = [ffmpeg]
      cmd.push('-i', input)
      cmd.push('-i', palettePath)
      cmd.push('-lavfi', '"' + filters + ' [x]; [x][1:v] paletteuse"')
      cmd.push('-y', output)
      cmd = cmd.join(' ')

      exec(cmd, callback)

module.exports = togif
