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
    $('#coef_w').val(($('#preview').data('width')/$('#cropbox').width()))
    $('#coef_h').val(($('#preview').data('height')/$('#cropbox').height()))
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
      width: Math.round(500/coords.w * $('#preview').data('width')/($('#preview').data('width')/$('#cropbox').width())) + 'px',
      height: Math.round(300/coords.h * $('#preview').data('height')/($('#preview').data('height')/$('#cropbox').height())) + 'px',
      marginLeft: '-' + Math.round(500/coords.w * coords.x) + 'px',
      marginTop: '-' + Math.round(300/coords.h * coords.y) + 'px'
