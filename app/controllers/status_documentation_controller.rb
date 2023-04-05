class StatusDocumentationController < ApplicationController
  def index

  end

  def people
    @people = Person.actives
    @assgined_type = 'people'
  end

  def vehicles
    @vehicles = Vehicle.actives
    @assgined_type = 'vehicles'
  end
end
