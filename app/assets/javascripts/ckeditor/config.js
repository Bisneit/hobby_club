CKEDITOR.editorConfig = function (config) {

  config.toolbar_mini = [
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline' ] },
    { name: 'align', groups: [ 'align' ], items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', ] },
    { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    { name: 'styles', items: [ 'Font', 'FontSize' ] }
  ];
  config.toolbar = "mini";
}
