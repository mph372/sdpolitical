$(document).on('turbolinks:load', function () {
    $('.form-control').on('input', function() {
      const searchInput = $(this);
      const query = searchInput.val();
      const dropdown = $('#' + searchInput.attr('data-dropdown-id'));
  
      if (query.length > 2) {
        fetch(`/people/search?q[last_name_cont]=${query}`)
            .then(response => response.json())
            .then(data => {
                let dropdownHTML = '<ul class="autocomplete-dropdown">';
                data.forEach(person => {
                    dropdownHTML += `<li><a href="/people/${person.id}">${person.last_name}, ${person.first_name}</a></li>`;
                });
                dropdownHTML += '</ul>';
                dropdown.html(dropdownHTML);
            })
            .catch(error => console.error('Error:', error));
      } else {
        dropdown.html('');
      }
    });
  });
  