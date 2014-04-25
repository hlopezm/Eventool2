destroy_grid = (id_grid) ->
  $(id_grid).jqGrid("GridUnload")

window.invitations_window = (event_id) ->
  $("#invitations_dialog").dialog
    close: ->
      $("#search").unbind("click")
      destroy_grid("#invitations")
    modal: true,
    open: ->
      invitations_grid(event_id)
      $("#search").css("display", "block")
      $("#search").on("click", -> people_window(event_id))
    width: 830,
    height: 340,
    position: "center"
    title: "Invitados"

window.people_window = (event_id) ->
  $("#people_dialog").dialog
    close: ->
      $("#invite").unbind("click")
      destroy_grid("#people")
    height: 340,
    modal: true,
    open: ->
      people_grid()
      $("#invite").css("display", "block")
      $("#invite").on "click", ->
        $.ajax
          url: "invite_people"
          data:
            people_ids: $("#people").getGridParam("selarrrow")
            event_id: event_id
          success: (data) ->
            $("#invitations").jqGrid('setGridParam', {url:"invitations_list", datatype:"json"}).trigger("reloadGrid")
            $("#people_dialog").dialog("close")

    position: "center",
    title: "Buscar Personas",
    width: 830,

window.invitations_grid = (event_id) ->
  $("#invitations").jqGrid
    url: "invitations_list",
    postData: {event_id: event_id}
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
    loadonce: true,
    rownumbers: true,
    pager: "#invitations_toolbar_search"

  $("#invitations").jqGrid("navGrid", "#invitations_toolbar_search", {del:false,add:false,edit:true,search:false})
  $("#invitations").jqGrid("filterToolbar", {stringResult: true,searchOnEnter: false})

window.people_grid = ->
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
    multiselect: true,
    ignoreCase: true,
    loadonce: true,
    rownumbers: true,
    pager: "#people_toolbar_search"

  $("#people").jqGrid('navGrid','#people_toolbar_search',{del:false,add:false,edit:true,search:false})
  $("#people").jqGrid('filterToolbar',{stringResult: true,searchOnEnter: false})

window.tasks_window = ->
  $("#tasks_dialog").dialog
    title: "Tareas"
    modal: true

link_guests = (cellValue, options, rowObject, action) ->
  "<a href='javascript:invitations_window(" + rowObject.id + ")'>Invitados</a>"

link_tasks = (cellValue, options, rowObject, action) ->
  "<a href='javascript:tasks_window()'>Tareas</a>"

grid_events = $("#events").jqGrid
  url: "events_list",
  datatype: "json",
  colNames: ["Nombre", "Inicio", "Fin", "Tareas", "Invitados"],
  colModel: [
    {name: "name"},
    {name: "start_at"},
    {name: "end_at"},
    {name: "tarks", align: "center", editable: true, formatter: link_tasks}
    {name: "guests", align: "center", editable: true, formatter: link_guests}
  ],
  loadonce: true,
  rownumbers: true,
  hoverrows: false,
  ignoreCase: true,
  pager: "#toolbar_search"

grid_events.jqGrid('navGrid','#toolbar_search',{del:false,add:false,edit:false,search:false})
grid_events.jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
