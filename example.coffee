toGif = require './'
path = require 'path'


input = path.resolve(__dirname, 'test.mp4')
output = path.resolve(__dirname, 'test.gif')
ffmpeg = path.resolve(__dirname, 'ffmpeg')

toGif input, output, {ffmpeg, rate: 15}, (err) ->
  console.log(err)
