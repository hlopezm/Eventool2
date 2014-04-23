$("#people").jqGrid({
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
  loadonce: true,
  rownumbers: true,
  pager: "toolbar_search"
})

$("#people").jqGrid('navGrid','#toolbar_search',{del:false,add:false,edit:false,search:false})
$("#people").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
