toGif = require './'
path = require 'path'


input = path.resolve(__dirname, 'test.mp4')
output = path.resolve(__dirname, 'test.gif')
ffmpeg = path.resolve(__dirname, 'ffmpeg')
convert = path.resolve(__dirname, 'convert')

toGif input, output, {ffmpeg, convert}, (err) ->
  console.log(err)
