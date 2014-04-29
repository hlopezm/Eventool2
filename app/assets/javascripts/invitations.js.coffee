destroy_grid = (id_grid) ->
  $(id_grid).jqGrid("GridUnload")

grid_invitations = $("#invitations").jqGrid
  url: "invitations_list",
  datatype: "json",
  colNames: ["Invitado", "invitationCreated", "Asigned","Sended", "Delivered", "Called" , "Assist", "NotAssist", "Undefined", "Notes"],
  colModel: [
    {name: "person.name"},
    {name: "created"},
    {name: "assigned"},
    {name: "sended"},
    {name: "delivered"},
    {name: "called"},
    {name: "assist"},
    {name: "not_assist"},
    {name: "undefined"},
    {name: "notes"},
  ],
  loadonce: true,
  rownumbers: true,
  hoverrows: false,
  ignoreCase: true,
  pager: "toolbar_search"

grid_invitations.jqGrid('navGrid','#toolbar_search',{del:false,add:false,edit:false,search:false})
grid_invitations.jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
