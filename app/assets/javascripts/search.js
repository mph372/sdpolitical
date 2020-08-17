document.addEventListener("turbolinks:load", function() {
    $input = $("[data-behavior='autocomplete']")
  
    var options = {
      getValue: "name",
      adjustWidth: false,


      url: function(phrase) {
        return "/search.json?q=" + phrase;
      },
      categories: [
        {
          listLocation: "people",
          header: "<strong>People</strong>",
        },
        {
          listLocation: "jurisdictions",
          header: "<strong>Jurisdictions</strong>",
        }
      ],
      list: {
        onChooseEvent: function() {
          var url = $input.getSelectedItemData().url
          $input.val("")
          Turbolinks.visit(url)
        }
      },

    }
  
    $input.easyAutocomplete(options)


  });