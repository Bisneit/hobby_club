jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 500/300
      setSelect: [0, 0, 500, 300]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#x').val(coords.x)
    $('#y').val(coords.y)
    $('#w').val(coords.w)
    $('#h').val(coords.h)
