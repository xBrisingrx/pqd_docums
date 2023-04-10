//= require rails-ujs
//= require activestorage

//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap
//= require unify/hs.megamenu
//= require unify/hs.core
//= require unify/components/hs.header
//= require unify/helpers/hs.hamburgers
//= require vendor/datatables/datatables
//= require vendor/noty/noty.min
//= require vendor/select2/select2.full
//= require custom

//= require vendor/jquery-validate/jquery.validate
//= require vendor/jquery-validate/additional-methods

//= require people
//= require profiles
//= require documents
//= require documents_profiles
//= require people_profiles
//= require vehicles_profiles
//= require status_documentation
//= require document_renovations
//= require reasons_to_disables
//= require vehicles
//= require insurances
//= require vehicle_insurances
//= require users
//= require clothes
//= require clothing_packages
//= require fuel_truks
//= require fuel_to_vehicles

$(document).on('ready', function () {
  // initialization of header
  $.HSCore.components.HSHeader.init($('#js-header'));
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  $('.js-mega-menu').HSMegaMenu({
   event: 'hover',
   pageContainer: $('.container'),
   breakpoint: 991
  });
});