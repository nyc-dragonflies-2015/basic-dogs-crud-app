$(document).ready(function() {

  $('.user-email').on('click', getUserEmail);
  $('.edit-user').on('click', getEditUserForm);
  $('.user').on('submit', '.edit-form' , editUser);
});

var editUser = function(event){
  
  event.preventDefault();
  var $target = $(event.target);
  var userDiv = $target.closest('.user');

  $.ajax({
      method: 'put',
      url: $target.attr('action'),
      data: $target.serialize(),
      dataType: 'json'
  }).done(function(response){
    this.children('.name').html(response.first_name + " " +response.last_name);
    this.find('.edit-user').toggle(true);
  }.bind(userDiv)).fail(function(error){
    console.log(error);
  });

};

var getEditUserForm = function(event){

  event.preventDefault();
  var $target = $(event.target);
  var userDiv = $target.closest('.user');
  var userId = $target.closest('.user').attr('id');
 
  $.ajax({
    url: '/users/' + userId + '/edit'
  }).done(function(response){
    this.children('.name').html(response);
    this.find('.edit-user').toggle(false);
  }.bind(userDiv))
  .fail(function(error){
    console.log(error);
  });

};

var getUserEmail = function(event){

    event.preventDefault();
    var $target = $(event.target);
    var userId =  $target.closest('.user').attr('id');
    var controllerMethod = 'get';
    var controllerRoute = '/users/' + userId + '/email.json'; 
      
    $.ajax({
      'url':      controllerRoute,
      'method':   controllerMethod,
      'dataType': 'json'
    }).done(function(response){ 
      var userDivSel = '#' + response.user_id;
      $( userDivSel+ '> .email' ).text( response.email );
      $( userDivSel+ '> .actions > .user-email' ).toggle( false );
    }).fail(function(error){
      console.log(error); 
    });
};
