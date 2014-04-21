# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#people").jqGrid({
  url: "people_list",
  datatype: "json",
  colNames: ["Nombre", "Titulo", "Dirección", "Telefono", "Email"],
  colModel: [
    {name: "name", width: 200},
    {name: "title"},
    {name: "address"},
    {name: "phone"},
    {name: "email"}
  ],
  
})
