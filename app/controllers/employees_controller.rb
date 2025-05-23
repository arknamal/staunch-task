require 'net/http'
require 'net/https'

class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_uri, only: [:index, :edit, :show, :create, :update]
  before_action :get_response, only: [:index, :edit, :show]
  
  def index
    @employees = JSON.parse(@response)
  end

  def edit
    @employee = JSON.parse(@response)
  end

  def show
    @employee = JSON.parse(@response)
  end

  def create
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = (@uri.scheme == 'https')
    request = Net::HTTP::Post.new(@uri.path)
    request['Content-Type'] = 'application/json'

    body = {
      "name": params[:name],
      "position": params[:position],
      "date_of_birth": params[:date_of_birth],
      "salary": params[:salary]
    }.to_json
    request.body = body

    response = http.request(request)

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

    @employee = JSON.parse(response.body)

    redirect_to employee_path(@employee.dig("id"))
  end

  def update
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = (@uri.scheme == 'https')
    request = Net::HTTP::Put.new(@uri.path)
    request['Content-Type'] = 'application/json'

    body = {
      "name": params[:name],
      "position": params[:position],
      "date_of_birth": params[:date_of_birth],
      "salary": params[:salary]
    }.to_json
    request.body = body

    response = http.request(request)

    puts "Response Code: #{response.code}"
    puts "Response Body: #{response.body}"

    @employee = JSON.parse(response.body)

    redirect_to edit_employee_path(@employee.dig("id"))
  end

  private

  def set_uri
    @uri = if params[:id].present?
             URI("https://dummy-employees-api-8bad748cda19.herokuapp.com/employees/#{params[:id]}")
           elsif params[:page].present?
             URI("https://dummy-employees-api-8bad748cda19.herokuapp.com/employees?page=#{params[:page]}")
           else
             URI('https://dummy-employees-api-8bad748cda19.herokuapp.com/employees')
           end
  end

  def get_response
    @response = Net::HTTP.get(@uri)
  end
end
