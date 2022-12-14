window.addEventListener('load', function() {
  console.log('PauseMenu Started By Gizeh')
})

window.addEventListener('message', function(event) {
  var v = event.data

  switch(v.action) {

      case 'show':
        ShowSettings()    
      break;
      case 'updatePlayers': 
        $('.players').text(`Connected Players ${v.total}/${v.max}`)
      break;
      case 'updatePlayersname': 
        $('.playername').text(`${v.name}`)
      break;
      case 'updatePlayersID': 
      $('.playerid').text(`ID : ${v.id}`)
      break;
  }
})

function ShowSettings() {
  $('.container').show(500)
  openUi = true
}

$(function(){
    $('#settingsOpen').click(function(){
      $.post('https://ViceCityPause/SendAction', JSON.stringify({action: 'settings'}));
      CloseAll()
    })
    $('#mapopen').click(function(){
      $.post('https://ViceCityPause/SendAction', JSON.stringify({action: 'map'}));
      CloseAll()
    })
    $('#touchem').click(function(){
      $.post('https:/ViceCityPause/SendAction', JSON.stringify({action: 'touche'}));
      CloseAll()
    })
    $('#exit').click(function(){
      CloseAll()
    })

    $('#discordinv').click(function(){
        window.invokeNative('openUrl', 'https://discord.gg/')
        CloseAll()
    })

    $('#tebexshop').click(function(){
      window.invokeNative('openUrl', 'https://gizeh.tebex.io/')
      CloseAll()
    })
})

function CloseAll(){
  $('.container').hide(500)
  $.post('https://ViceCityPause/exit', JSON.stringify({}));
}