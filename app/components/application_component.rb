# typed: strict

class ApplicationComponent < ViewComponent::Base
  include ApplicationHelper
  extend T::Sig

  sig { params(form_object: ActionView::Helpers::FormBuilder, action: T.any(String, Symbol)).returns(String) }
  def commit_name_for(form_object, action)
    "#{form_object.object_name}[commit][#{action}]"
  end
end
