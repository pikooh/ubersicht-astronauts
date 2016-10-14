command: 'curl -s "http://api.open-notify.org/astros.json"'

#refresh daily
refreshFrequency: 21000000

style: """
  top: 10px
  left: 10px
  color: #fff

  .output p,
  .output ul
    margin: 0

  .output
    font-family: Helvetica Neue
    font-size: 20px
    font-weight: 200
    text-shadow: 0 1px 5px #000000;

  ul li
    font-size: 16px

  #error
    display: none
"""

render: (output) -> """
  <div class="output">
    <p id="success">
      <span id="num">?</span> People in Space right now<br>
      <ul id="people"></ul>
    </p>
    <p id="error">Not sure how many people are in space...</p>
  </div>
"""

update: (output, domEl) ->
  jsonData = jQuery.parseJSON(output)
  success = jsonData.message == "success"

  $(domEl).find('#error').toggle( !success )
  $(domEl).find('#success').toggle( success )

  if success
    numOfPeople = jsonData.number
    $(domEl).find('#num').html numOfPeople

    $(domEl).find('#people').html ""
    for person in jsonData.people
      $(domEl).find('#people').append '<li>'+person.name+'</li>'
