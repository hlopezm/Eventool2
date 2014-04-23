window.people_window = ->
  $("#people_dialog").dialog
    title: "Invitados",
    modal: true,
    open: -> grid_people(),
    width: 830,
    position: "center"

window.grid_people = ->
  $("#people").jqGrid
    url: "people_list",
    datatype: "json",
    colNames: ["Nombre", "Titulo", "Dirección", "Telefono", "Email"],
    colModel: [
      {name: "name"},
      {name: "title"},
      {name: "address"},
      {name: "phone"},
      {name: "email"}
    ],
    ignoreCase: true,
    multiselect: true,
    loadonce: true,
    rownumbers: true,
    pager: "toolbar_search"

  $("#people").jqGrid('navGrid','#people_toolbar_search',{del:false,add:false,edit:false,search:false})
  $("#people").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})


window.tasks_window = ->
  $("#tasks_dialog").dialog
    title: "Tareas"
    modal: true

link_guests = (cellValue, options, rowObject, action) ->
  "<a href='javascript:people_window()'>Invitados</a>"

link_tasks = (cellValue, options, rowObject, action) ->
  "<a href='javascript:tasks_window()'>Tareas</a>"

grid_events = $("#events").jqGrid
  url: "events_list",
  datatype: "json",
  colNames: ["Nombre", "Inicio", "Fin", "Tareas", "Invitados"],
  colModel: [
    { name: "name" },
    { name: "start_at" },
    { name: "end_at" },
    { name: "tarks", align: "center", editable: true, formatter: link_tasks }
    { name: "guests", align: "center", editable: true, formatter: link_guests }
  ],
  loadonce: true,
  rownumbers: true,
  hoverrows: false,
  ignoreCase: true,
  pager: "toolbar_search"

grid_events.jqGrid('navGrid','#toolbar_search',{del:true,add:true,edit:true,search:false})
grid_events.jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
