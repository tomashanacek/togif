# To GIF

Convert video to gif

## Installation

```
npm install togif
```

## Example

```
var toGif = require 'togif'

var input = path.resolve(__dirname, 'test.mp4')
var output = path.resolve(__dirname, 'test.gif')
var ffmpeg = path.resolve(__dirname, 'ffmpeg')

toGif(input, output, {ffmpeg: ffmpeg}, function(err) {
  console.log(err)
})

```
