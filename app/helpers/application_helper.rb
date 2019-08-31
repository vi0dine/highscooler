# frozen_string_literal: true

module ApplicationHelper
  def link_to_add_exam(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_exam ' + args[:class], data: {id: id, fields: fields.gsub('\n', '')})
  end

  def link_to_add_interest(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_interest ' + args[:class], data: {id: id, fields: fields.gsub('\n', '')})
  end
end
