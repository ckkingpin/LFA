class CategoriesController < ApplicationController
  load_and_authorize_resource

  def new
    @category = Category.new
  end

  def categories_names
    @categories = Category.find(params[:category_ids].split(','))
    @res = []
    @categories.each {|category| @res << {name: category.name, id: category.id}}
    render json: {res: @res}
  end

  def add_category
    @category = Category.new(name: params[:name])
    if @category.save
      render json: {id: @category.id, name: @category.name}
    end
  end

  def autocomplete
    categories = Category.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.json do
        render json: categories.map {|u| {id: u.id, name: u.name}}
      end
    end
  end
end
