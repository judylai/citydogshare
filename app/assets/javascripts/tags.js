$(document).ready(function() {
  $("#myTags").tagit({
    tagSource: function(search, showChoices) {
      var that = this;
      $.ajax({
        url: "/mixes/autocomplete.json",
        data: {q: search.term},
        success: function(choices) {
          showChoices(that._subtractArray(choices, that.assignedTags()));
        }
      });
    },
  });
});