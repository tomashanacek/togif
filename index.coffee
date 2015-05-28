{exec} = require 'child_process'
escape = require 'shell-escape'
path = require 'path'
temp = require('temp').track()


togif = (input, output, options, callback) ->
  rate = options.rate or 10
  ffmpeg = options.ffmpeg or 'ffmpeg'
  convert = options.convert or 'convert'

  delay = 100 / rate / 1
  input = escape([input])
  output = escape([output])

  temp.mkdir {}, (err, tempDir) ->
    return callback(err) if err

    tempPath = path.join(tempDir, '/%04d.png')

    cmd = [ffmpeg]
    cmd.push('-i', input)
    cmd.push('-r', String(rate))
    cmd.push(tempPath)
    cmd = cmd.join(' ')

    exec cmd, (err) ->
      return callback(err) if err

      cmd = [convert]
      cmd.push('+dither')
      cmd.push('-layers', 'Optimize')
      cmd.push('-delay', String(delay))
      cmd.push(path.join(tempDir, '/*.png'))
      cmd.push(output)
      cmd = cmd.join(' ')

      exec(cmd, callback)

module.exports = togif
