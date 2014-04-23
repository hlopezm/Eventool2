link_guests =(cellValue, options, rowObject, action)->
  "<a href='#'>Invitados</a>"

link_tasks =(cellValue, options, rowObject, action)->
  "<a href='#'>Tareas</a>"

grid_events = $("#events").jqGrid({
  url: "events_list",
  datatype: "json",
  colNames: ["Nombre", "Inicio", "Fin", "Tareas", "Invitados"],
  colModel: [
    {name: "name"},
    {name: "start_at"},
    {name: "end_at"},
    {name: "tarks", align: "center", editable: true, formatter: link_tasks }
    {name: "guests", align: "center", editable: true, formatter: link_guests }
  ],
  loadonce: true,
  rownumbers: true,
  hoverrows: false,
  pager: "toolbar_search"
})



grid_events.jqGrid('navGrid','#toolbar_search',{del:false,add:false,edit:false,search:false})
grid_events.jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
