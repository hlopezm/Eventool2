
grid_tasks = $("#tasks").jqGrid
  url: "tasks_list",
  datatype: "json",
  colNames: ["Nombre", "Inicio", "Asignado a", "Finalizado"],
  colModel: [
    {name: "title"},
    {name: "created_at"},
    {name: "user.email"},
    {name: "finish"}
  ],
  loadonce: true,
  rownumbers: true,
  hoverrows: false,
  ignoreCase: true,
  pager: "toolbar_search"

grid_tasks.jqGrid('navGrid','#toolbar_search',{del:false,add:false,edit:false,search:false})
grid_tasks.jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
