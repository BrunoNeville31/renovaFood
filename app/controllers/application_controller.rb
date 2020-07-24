class ApplicationController < ActionController::Base
    layout :set_devise


    def set_devise        
        if devise_controller?
            "#{resource_class.name.downcase}_devise"
        end
    end
end
